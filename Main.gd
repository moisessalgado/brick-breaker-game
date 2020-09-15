extends Node2D


var ball_scene
var ball
var brick_scene
var hud
var playing = false
var score = 0
var score_label
var screen_size


func _ready():
	screen_size = get_viewport_rect().size
	$Platform.position.x = screen_size.x / 2
	$Platform.position.y = screen_size.y - (screen_size.y / 20)
	ball_scene = preload("res://Scenes/Ball.tscn")
	brick_scene = preload("res://Scenes/Brick.tscn")
	hud = $HUD
	score_label = hud.score

func _process(delta):
	if !playing:
		if Input.get_action_strength("ui_accept"):
			new_game()

func _on_Walls_body_has_escaped(body):
	if body == ball:
		ball.queue_free()
		call_deferred("game_over")
		

func new_game():
	playing = true
	hud.info.text = ""
	ball = ball_scene.instance()
	ball.position.x = rand_range(0, screen_size.x)
	ball.position.y = screen_size.y - (screen_size.y / 4)
	add_child(ball)
	create_bricks()

func game_over():
	playing = false
	hud.info.text = "Game Over \n you break " + str(score) + " bricks \n press enter to restart"
	score = 0
	score_label.text = "you break " + str(score) + " bricks"
	var bricks = get_tree().get_nodes_in_group("bricks")
	for brick in bricks:
		brick.queue_free()

func set_score():
	score += 1
	score_label.text = "you break " + str(score) + " bricks"
	
func create_bricks():
	var brick = brick_scene.instance()
	var allowed_height = int(screen_size.y / 3.0)
	var allowed_width = int(screen_size.x)
	var brick_height = brick.size_y * 2
	var brick_width = brick.size_x * 2
	var bricks_vertical_area = (allowed_height - (allowed_height % brick_height)) + brick_width
	var bricks_horizontal_area = allowed_width - (allowed_width % brick_width)
	var width = ((allowed_width - bricks_horizontal_area) / 2) + brick_height
	var start_width = width
	var height = ((allowed_height - bricks_vertical_area) / 2) + (brick_width * 1.5)
	
	while height <= bricks_vertical_area:
		while width <= bricks_horizontal_area:
			var brick_instance = brick_scene.instance()
			brick_instance.position = Vector2(width, height)
			add_child(brick_instance)
			width += brick_width
		height += brick_height
		width = start_width


