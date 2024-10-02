extends ColorRect

var test = false

func _ready():
	pass 


func _process(delta):
	pass


#i have no idea why using the body_entered signal jus does not work with the unit scene, even doe
#it is in the isUnit grp. the area signal works fine so im jus gonna use that
func _on_area_2d_area_entered(area):
	if area.is_in_group("isUnit"):
		print("WORKING")


func _on_area_2d_area_exited(area):
	if area.is_in_group("isUnit"):
		print("WORKING AGAIN")
