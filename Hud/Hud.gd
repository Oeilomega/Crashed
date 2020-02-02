extends CanvasLayer

# Declare member variables here.
const HEART_OFFSET = 48
const HEARTS_MAX   = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	for index in HEARTS_MAX:
		var heart = Sprite.new()
		
		heart.texture = $Hearts.texture
		heart.hframes = $Hearts.hframes
		
		var x = index * HEART_OFFSET
		var y = 0
		heart.position = Vector2(x, y)
		
		$Hearts.add_child(heart)
#	update_hearts(HEARTS_MAX)

func update_hearts(value):
	for heart in $Hearts.get_children():
		var index = heart.get_index()
		
		heart.frame = 1 if index < value else 0
