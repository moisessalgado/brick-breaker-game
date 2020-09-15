extends KinematicBody2D

var ball_damage = 1
export var speed = 200
var speed_increase_rate = 1.01
var velocity = Vector2()


func _ready():
	velocity = Vector2(-1, -1) * speed


func _physics_process(delta):
	var colision = move_and_collide(velocity * delta)
	if colision:
		velocity = velocity.bounce(colision.normal) * speed_increase_rate
		ball_colision(colision.collider)

func ball_colision(colider):
	if colider.has_method("break_brick"):
		colider.break_brick(ball_damage)
		

