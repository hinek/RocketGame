extends Area2D


const EXPLOSION_TYPE = preload("res://Explosion.tscn")
const MOVEMENT_SPEED = 250


var invincibility = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = Vector2(500, get_global_mouse_position().y)
	var target_angle = position.angle_to_point(mouse_pos) + PI
	rotation = target_angle
	var movement = target_angle if target_angle < PI else -(2*PI-target_angle)
	position.y = clamp(position.y + movement * delta * MOVEMENT_SPEED, 30, 570)
	
	if invincibility > 0:
		invincibility -= delta
		$Sprite.modulate.a = 1.0 if int(invincibility * 30) % 2 == 0 else 0.2



func _on_Rocket_area_entered(area):
	if invincibility <= 0:
		get_parent().call_deferred("rocket_damaged")
		var explosion = EXPLOSION_TYPE.instance()
		explosion.position = area.position
		get_parent().add_child(explosion)
		area.queue_free()
		invincibility = 2
