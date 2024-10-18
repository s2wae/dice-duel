extends Control


const address = "127.0.0.1"
const port = 9999

var maxPlayers = 4
var playerName


func ready():
	pass


@rpc("any_peer", "call_local")
func start_game():
	Global.goto_scene("res://scenes/playerUI.tscn")


func _on_host_button_pressed():
	playerName = $nameBox.text
	GameManager.curPlayerName = playerName
	await get_tree().create_timer(0.3).timeout
	GameManager.host_pressed()


func _on_join_button_pressed():
	playerName = $nameBox.text
	GameManager.curPlayerName = playerName
	await get_tree().create_timer(0.3).timeout
	GameManager.join_pressed()


func _on_start_button_pressed():
	start_game.rpc()
	for i in GameManager.players:
		print(GameManager.players[i])
