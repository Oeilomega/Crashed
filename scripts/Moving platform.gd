extends RigidBody2D

export (int) var speed = 3
export var longeur = Vector2(320,0)

func _ready():
	move()
	pass

func move():
	$Tween.interpolate_property(self,
	 "position",
	global_position,
	global_position + longeur,
	speed,
	Tween.TRANS_SINE,
	Tween.EASE_IN_OUT)	
	$Tween.start()
func _process(delta):
	pass


func _on_Tween_tween_completed(object, key):
	longeur *= -1
	move()
