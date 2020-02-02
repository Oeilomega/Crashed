extends KinematicBody2D

const GROUND = Vector2(0,-1)
const GRAVITY = 10
const ACCEL = 50
const MAX_SPEED = 300
const JUMP = -390
var motion = Vector2(0,0)
var jump_count = 0
var direction = 1
var invulnerable = false
onready var sprite = get_node("Sprite")
onready var hud    = get_node("../Hud")

func _ready():
	print("Hello")
	hud.update_hearts($Health.max_value)

func _physics_process(delta):
	var friction = false
	motion.y = min(motion.y + GRAVITY, GRAVITY * MAX_SPEED)

	if Input.is_action_pressed("ui_right"):
		direction = 1
		motion.x = min(motion.x + ACCEL, MAX_SPEED)
		sprite.flip_h = false
		sprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		motion.x = max(motion.x - ACCEL, -MAX_SPEED)
		sprite.flip_h = true
		sprite.play("run")
	else:
		friction = true
		sprite.play("idle")

	if is_on_floor():
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		jump_count = 0
	else:
		if motion.y <= 0:
			sprite.play("jump")
		else:
			sprite.play("fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.1)
	if Input.is_action_just_pressed("ui_up") and jump_count < 1:
		motion.y = JUMP
		jump_count += 1
	motion = move_and_slide(motion, GROUND)

func _on_body_entered(body):
	if body.name == "Player" and not invulnerable:
		invulnerable = true
		$Health.set_value($Health.value- 1)

func _on_body_exited(body):
	if body.name == "Player":
		invulnerable = false

func _on_Health_changed(value):
	if value == 0:
		get_tree().quit()
	hud.update_hearts(value)

func _on_Hud_ready():
	hud.update_hearts($Health.max_value)
