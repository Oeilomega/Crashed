extends KinematicBody2D

const GROUND = Vector2(0,-1)
const GRAVITY = 10
const ACCEL = 50
const MAX_SPEED = 300
const JUMP = -390
var motion = Vector2(0,0)
var direction = 1
var can_pick = true
onready var sprite = get_node("Sprite")

func _physics_process(delta):
	var friction = false
	motion.y = min(motion.y + GRAVITY, GRAVITY * MAX_SPEED)

	if Input.is_action_pressed("ui_right"):
		direction = 1
		motion.x = min(motion.x + ACCEL, MAX_SPEED)
		sprite.flip_h = false
		if $Pick.position.x < 0:
			$Pick.position.x *= -1
		sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		motion.x = max(motion.x - ACCEL, -MAX_SPEED)
		sprite.flip_h = true
		if $Pick.position.x > 0:
			$Pick.position.x *= -1
		sprite.play("run")
	else:
		friction = true
		sprite.play("idle")

	if is_on_floor():
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		if Input.is_action_just_pressed("ui_up"):
			$sounds/jump.play()
			motion.y = JUMP

	else:
		if motion.y <= 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
	motion = move_and_slide(motion, GROUND)
