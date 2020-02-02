extends Node

var frames
var repaired = false

# warning-ignore:unused_argument
func _process(delta):
	var obj = [false, false, false, false]
	var bodies = $End_Zone.get_overlapping_bodies()

	for b in bodies:
		if b.name == "Object1":
			obj[0] = true
		elif b.name == "Object2":
			obj[1] = true
		elif b.name == "Object3":
			obj[2] = true
		elif b.name == "Object4":
			obj[3] = true
		else:
			pass
	
	if obj[0] == true and obj[1] == true and obj[2] == true and obj[3] == true:
		$Crates/Object1.queue_free()
		$Crates/Object2.queue_free()
		$Crates/Object3.queue_free()
		$Crates/Object4.queue_free()
		get_node("Rocket/AnimationPlayer").play("repaired")
		repaired = true
	
	if repaired == true:
		bodies = $End_Zone2.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player":
				get_tree().change_scene("res://scenes/Ending.tscn")
