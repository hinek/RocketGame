extends Label


var speed = 50
var visibility = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	margin_top -= delta * speed
	visibility -= delta
	if visibility <= 0:
		queue_free()
		return
	
	set("custom_colors/font_color", Color(1,1,1, visibility))
