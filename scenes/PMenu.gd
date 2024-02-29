extends Control



@onready var PlayerCharacter = get_node("/root/main/2d_player_char")

var notPaused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("pause")
	
	if PlayerCharacter.pause == true:
		
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
	print("dead")
	get_tree().quit()


func _on_resumeBtn_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	notPaused = true
	visible = false
