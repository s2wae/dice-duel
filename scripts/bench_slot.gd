extends ColorRect

var isBeingUsed = false
var benchSlotId = -1

func _ready():
	pass 


func _process(delta):
	pass


#i have no idea why using the body_entered signal jus does not work with the unit scene, even doe
#it is in the isUnit grp. the area signal works fine so im jus gonna use that
func _on_area_2d_area_entered(area):
	if area.is_in_group("isUnit"):
		isBeingUsed = true
		print("WORKING")


func _on_area_2d_area_exited(area):
	if area.is_in_group("isUnit"):
		isBeingUsed = false
		print("WORKING AGAIN")
