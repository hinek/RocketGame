extends CanvasLayer


const PAUSE_KEY = 112


func _input(event):
	if event is InputEventKey && event.is_pressed() && event.unicode == PAUSE_KEY:
		get_tree().paused = !get_tree().paused
		$GamePaused.visible = get_tree().paused
