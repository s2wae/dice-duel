extends Node


var peer = ENetMultiplayerPeer.new()
var port = 9999
var maxPlayers = 4

func ready():
	peer.peer_connected.connect(_player_connected)
	peer.peer_disconnected.connect(_player_disconnected)


func start_server():
	var error = peer.create_server(port, maxPlayers)
	if error:
		print("Cannot host: " + error)
		return
	multiplayer.set_multiplayer_peer(peer)
	print("Server started!")
	


func _player_connected(id):
	print("Player " + str(id) + " connected!")

func _player_disconnected(id):
	print("Player " + str(id) + " disconnected!")
