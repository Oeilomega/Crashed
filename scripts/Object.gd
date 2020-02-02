extends KinematicBody2D

const GROUND = Vector2(0,-1)
const GRAVITY = 8
const MAX_SPEED = 300
var motion = Vector2(0,0)
var picked = false
var just_dropped = false

func _physics_process(delta):
	if picked == true:
		self.position = get_node("../../Player/Lift").global_position
	else:
		if is_on_floor():
			motion.y = 0
			motion.x = lerp(motion.x, 0, 0.2)
		else:
			motion.y = min(motion.y + GRAVITY, GRAVITY * MAX_SPEED)
		motion = move_and_slide(motion, GROUND)
	
func _input(event):
	var pick_action = false

	just_dropped = false
	if Input.is_action_just_pressed("ui_accept"):
		var bodies = $Detector.get_overlapping_bodies()
		for b in bodies:
			if b.name == "Player" && picked == false && get_node("../../Player").can_pick == true:
				get_node("../../Player").can_pick = false
				picked = true
				pick_action = true
		if pick_action == false:
			if self.position == get_node("../../Player/Lift").global_position:
				self.position = get_node("../../Player/Pick").global_position
			just_dropped = true
			picked = false
			get_node("../../Player").can_pick = true
