extends Node


#FIXC EVERY THIGN TIURED

const address = "127.0.0.1"
const port = 9999

var peer
var maxPlayers = 4
var players = {}
var curPlayerName


func _ready():
	multiplayer.peer_connected.connect(_player_connected)
	multiplayer.peer_disconnected.connect(_player_disconnected)
	multiplayer.connected_to_server.connect(_connected_ok)
	multiplayer.connection_failed.connect(_connected_fail)
	multiplayer.server_disconnected.connect(_server_disconnected)


@rpc("any_peer")
func sendPlayerInfo(name, id, readyState):
	print("BEING CALLED")
	
	if !players.has(id):
		players[id] = {
			"name": name,
			"id": id,
			"readyState": readyState
		}
	
	if multiplayer.is_server():
		for i in players:
			sendPlayerInfo.rpc(players[i].name, i)



func host_pressed():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, maxPlayers)
	if error != OK:
		printerr("Cannot host lol")
		return
	multiplayer.set_multiplayer_peer(peer)
	sendPlayerInfo(curPlayerName, multiplayer.get_unique_id(), 0)
	print(multiplayer.get_unique_id())
	print("Server started!")
	print("Waiting for players!")



func join_pressed():
	peer = ENetMultiplayerPeer.new()
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
	sendPlayerInfo.rpc_id(1, curPlayerName, multiplayer.get_unique_id(), 0)
	print("Successfully connected!")

func _connected_fail():
	print("Failed to connect!")

func _server_disconnected():
	print("Server disconnected!")



