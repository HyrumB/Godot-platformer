extends Control



var notPaused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_end") || Input.is_action_just_pressed("Pause"):
		if notPaused == true:
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			notPaused = false
			visible = true
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			notPaused = true
			visible = false
			


func _on_extGmBtn_pressed():
	get_tree().quit()


func _on_resumeBtn_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	notPaused = true
	visible = false
