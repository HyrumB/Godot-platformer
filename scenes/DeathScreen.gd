extends Control



#var player_health = get_node('PlayerCharacter').player_health
var notPaused = true
@onready var PlayerCharacter = get_node("/root/main/2d_player_char")

func _ready():
	set_process(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("dead")
	if PlayerCharacter.health <= 0:
		
		if notPaused == true:
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			visible = true
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			notPaused = true
			visible = false
			




#func _on_ReSpnBtn_pressed():
#	print("put character respawn code here")


func _on_extGmBtn2_pressed():
	get_tree().quit()
