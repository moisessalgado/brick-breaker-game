extends StaticBody2D

export var speed = 500
var size
var velocity = Vector2()

var screen_size
var position_min
var position_max


func _ready():
	screen_size = get_viewport_rect().size
	size = $CollisionShape2D.shape.height
	position_min = size / 2
	position_max = screen_size.x - size / 2


func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	position += (velocity * speed) * delta
	position.x = clamp(position.x, position_min, position_max)
