extends Node2D


const EXPLOSION_TYPE = preload("res://Explosion.tscn")
const OBSTACLE_TYPES = [
	preload("res://Screen.tscn"),
	preload("res://Keyboard.tscn"),
	preload("res://Mouse.tscn")
]


var next_obstacle_type = 0
var damage = 0
var score = 0
var game_over = false


# Called when the node enters the scene tree for the first time.
func _ready():
	create_obstacle()
	$NextObstacleTimer.start()


func create_obstacle():
	var new_obstacle = OBSTACLE_TYPES[next_obstacle_type].instance()
	$Obstacles.add_child(new_obstacle)
	next_obstacle_type = (next_obstacle_type + 1) % OBSTACLE_TYPES.size()


func _on_NextObstacleTimer_timeout():
	if game_over:
		return
	
	create_obstacle()
	if $NextObstacleTimer.wait_time < 15:
		$NextObstacleTimer.wait_time += 1
	$NextObstacleTimer.start()


func add_score(points):
	if game_over:
		return
	
	score += points
	$HUD/Background/Score.text = "%010d" % score


func rocket_damaged():
	damage += 1
	$HUD/Background/HealthBar.text = "3939".substr(0, damage)
	if damage > 3:
		gameover()


func gameover():
	game_over = true
	var explosion = EXPLOSION_TYPE.instance()
	explosion.position = $Rocket.position
	add_child(explosion)
	$Rocket.queue_free()
	$HUD/GameOver.show()


func _on_TryAgain_gui_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == 1 && game_over:
		get_tree().reload_current_scene()
