extends Node


const SERVER_IP = "127.0.0.1"
const SERVER_PORT = 9999

var peer = ENetMultiplayerPeer.new()
var selected_ip
var selected_port

var localPlayerID = 0
var clientName


func ready():
	multiplayer.network_peer_connected.connect(_player_connected)
	multiplayer.network_peer_disconnected.connect(_player_disconnected)
	multiplayer.connection_failed.connect(_connected_fail)
	multiplayer.server_disconnected.connect(_server_disconnected)


func _connect_to_server():
	multiplayer.connected_to_server.connect(_connected_ok)
	var error = peer.create_client(SERVER_IP, SERVER_PORT)
	if error:
		print("FAIL IDK Y" + error)
	multiplayer.set_multiplayer_peer(peer)


func _player_connected(id):
	print("Player " + str(id) + " connected!")

func _player_disconnected(id):
	print("Player " + str(id) + " disconnected!")

func _connected_ok():
	sendPlayerInfo.rpc_id(1, clientName, multiplayer.get_unique_id())
	print("Successfully connected!")

func _connected_fail():
	print("Failed to connect!")

func _server_disconnected():
	print("Server disconnected!")

@rpc("any_peer")
func sendPlayerInfo(name, id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id
		}
	
	if multiplayer.is_server():
		for i in GameManager.players:
			sendPlayerInfo.rpc(GameManager.players[i].name, i)
