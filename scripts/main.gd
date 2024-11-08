extends Node2D

@onready var battleCam = $battleNode/battleCam
@onready var l1 = $"spawnNodes/0/0"
@onready var l2 = $"spawnNodes/1/1"
@onready var player = preload("res://scenes/player.tscn")

var readyCount = 0
var pID = []

func _ready():
	getID()
	var index = 0
	for spawn in get_tree().get_nodes_in_group("spawnPoint"):
		if spawn.name == str(index):
			var curPlayer = player.instantiate()
			curPlayer.name = str(pID[index])
			add_child(curPlayer)
			curPlayer.reparent(spawn)
			curPlayer.global_position = spawn.global_position
		for pName in get_tree().get_nodes_in_group("playerName"):
			if pName.name == str(index):
				pName.text = str(pID[index])
		index += 1
	pass
	



func _process(delta):
	$tester.make_current()
	pass
	
#the problem is that it is spawning the same board on both sides, instead of two players
#fix this when back
#just use spawning both players again

func getID() -> void :
	if !pID.is_empty(): return
	
	for i in GameManager.players:
		pID.append(GameManager.players[i].id)


@rpc("any_peer", "call_local")
func battle_phase():
	battleCam.enabled = true
	battleCam.make_current()



func _on_ready_button_pressed():
	var curID = multiplayer.get_unique_id()
	GameManager.ready.rpc(curID)
	
	for i in GameManager.players:
		if GameManager.players[i].readyStatus == 1:
			readyCount += 1
	print(readyCount)
	if readyCount == 2:
		battle_phase.rpc()
	else:
		readyCount = 0


func _on_ready_button_1_pressed():
	var curID = multiplayer.get_unique_id()
	GameManager.ready.rpc(curID)
	
	for i in GameManager.players:
		if GameManager.players[i].readyStatus == 1:
			readyCount += 1
	print(readyCount)
	if readyCount == 2:
		battle_phase.rpc()
	else:
		readyCount = 0

#kind of works now do multiplayer synchronizing stuff
