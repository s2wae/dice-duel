extends Control


func ready():
	pass

@rpc("any_peer", "call_local")
func start_game():
	Global.goto_scene("res://scenes/playerUI.tscn")


func _on_join_button_pressed():
	Client._connect_to_server()
	Client.clientName = $nameBox.text


func _on_host_button_pressed():
	Server.start_server()
	print("Waiting for players!")
	Client.sendPlayerInfo($nameBox.text, multiplayer.get_unique_id())


func _on_start_button_pressed():
	start_game.rpc()
