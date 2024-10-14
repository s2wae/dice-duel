extends Control


var multiplayerPeer = ENetMultiplayerPeer.new()
var connectedPeerIDs = []

const SERVER_ADDRESS = "127.0.0.1"
const SERVER_PORT = 9999

func _on_host_button_pressed():
	Global.goto_scene("res://scenes/playerUI.tscn")
	multiplayerPeer.create_server(SERVER_PORT)
	multiplayer.multiplayer_peer = multiplayerPeer
	
	add_player(1)
	
	multiplayerPeer.peer_connected.connect(
		func(newPeerID):
			await get_tree().create_timer(1).timeout
			rpc("add_newly_connected_player")
			rpc_id(newPeerID, "add_previously_connected_players", connectedPeerIDs)
			add_player(newPeerID)
	)


func _on_join_button_pressed():
	Global.goto_scene("res://scenes/playerUI.tscn")
	multiplayerPeer.create_client(SERVER_ADDRESS, SERVER_PORT)
	multiplayer.multiplayer_peer = multiplayerPeer
	

func add_player(peerID):
	connectedPeerIDs.append(peerID)

@rpc
func add_newly_connected_player(newPeerID):
	add_player(newPeerID)

@rpc
func add_previously_connected_players(peerIDs):
	for peerID in peerIDs:
		add_player(peerID)
