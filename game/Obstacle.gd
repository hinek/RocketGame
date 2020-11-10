extends Area2D


var movement_speed = 200
var rotation_speed = 50
var was_passed = false


# Called when the node enters the scene tree for the first time.
func _ready():
	reset()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= movement_speed * delta
	rotation_degrees += rotation_speed * delta
	if position.x < 100 && !was_passed:
		passed()
	if position.x < -100:
		reset()


func passed():
	was_passed = true
	var scene = get_tree().current_scene
	if scene.game_over:
		return
	
	scene.call_deferred("add_score", 1)
	var score_indicator = load("res://ScoreAdded.tscn").instance()
	score_indicator.margin_left = position.x
	score_indicator.margin_top = position.y
	get_parent().add_child(score_indicator)


func reset():
	position = Vector2(1100, rand_range(50, 550))
	movement_speed = rand_range(200, 300)
	rotation_speed = rand_range(-70, 70)
	was_passed = false