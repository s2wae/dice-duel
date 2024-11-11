extends Node


#FIXC EVERY THIGN TIURED

const address = "127.0.0.1"
const port = 9999

var peer
var maxPlayers = 2
var players = {}
var curPlayerName


func _ready():
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	multiplayer.connected_to_server.connect(_connected_ok)
	multiplayer.connection_failed.connect(_connected_fail)
	multiplayer.server_disconnected.connect(_server_disconnected)


func clone(node: Node) -> Node:
	var copy = node.duplicate()
	var properties: Array = node.get_property_list()
	var script_properties: Array = []

	for prop in properties:
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == PROPERTY_USAGE_SCRIPT_VARIABLE:
			script_properties.append(prop)
	
	for prop in script_properties:
		copy.set(prop.name, node[prop.name])
	
	return copy





@rpc("any_peer", "call_local")
func click():
	Global.clicking = true


@rpc("any_peer", "call_local")
func unclick():
	Global.clicking = false



@rpc("any_peer")
func sendPlayerInfo(name, id, readyStatus, curBoard):
	print("BEING CALLED")
	
	if !players.has(id):
		players[id] = {
			"name": name,
			"id": id,
			"readyStatus": readyStatus,
			"curBoard": curBoard
		}
	
	if multiplayer.is_server():
		for i in players:
			sendPlayerInfo.rpc(players[i].name, i, readyStatus, curBoard)

@rpc("any_peer", "call_local")
func unready(id):
	if GameManager.players[id].readyStatus == 1:
		GameManager.players[id].readyStatus = 0

@rpc("any_peer", "call_local")
func ready(id):
	if GameManager.players[id].readyStatus != 1:
		print("ready now")
		GameManager.players[id].readyStatus = 1
		#for i in GameManager.players: 
			#if GameManager.players[i].readyStatus == 1:
				#readyCount += 1
		#if readyCount == len(GameManager.players):
	#`		pass



func host_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.get_var(true)
	var error = peer.create_server(port, maxPlayers)
	if error != OK:
		printerr("Cannot host lol")
		return
	multiplayer.set_multiplayer_peer(peer)
	sendPlayerInfo(curPlayerName, multiplayer.get_unique_id(), 0, null)
	print(multiplayer.get_unique_id())
	print("Server started!")
	print("Waiting for players!")



func join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.get_var(true)
	var error = peer.create_client(address, port)
	if error != OK:
		printerr("Cannot join lol")
		return
	multiplayer.set_multiplayer_peer(peer)
	print(multiplayer.get_unique_id())


func _player_connected(id):
	print("Player " + str(id) + " connected!")

func _player_disconnected(id):
	print("Player " + str(id) + " disconnected!")

func _connected_ok():
	sendPlayerInfo.rpc_id(1, curPlayerName, multiplayer.get_unique_id(), 0, null)
	print("Successfully connected!")

func _connected_fail():
	print("Failed to connect!")

func _server_disconnected():
	print("Server disconnected!")



