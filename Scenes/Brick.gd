extends StaticBody2D


var life = int(rand_range(1, 5))
var main
var size_x = 50 # shape.extents.x
var size_y = 20 # shape.extents.y
var sprite


func _ready():
	main = get_parent()
	sprite = $Sprite
	create_brick()
	
func create_brick():
	match life:
		2:
			sprite.modulate = Color8(200, 100, 100)
		3:
			sprite.modulate = Color8(150, 100, 100)
		4:
			sprite.modulate = Color8(100, 50, 50)
	
func break_brick(damage):
	life -= damage
	if life <= 0:
		main.set_score()
		hide()
		queue_free()
