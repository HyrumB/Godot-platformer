extends CharacterBody2D
# https://forum.godotengine.org/t/hold-to-jump-higher-system-for-godot-4/37835/2

const MAX_FALLING_VELOCITY = 500
const GRAVITY = 300 #200
const MOVE_SPD = 300
const JUMP_PWR = -1000 #-1000

# States would help for more advanced mechanics such as double jump, etc.
enum JumpState {READY, JUMPING, FALLING}
var current_jump_state : JumpState
var elapsed_jump_time : float = 0.0

var pause = false
var health =  0

@export var jump_duration : float = 0.10 #2.0


func _physics_process(delta): #this runs when an input is held
	var motion = velocity * delta
	move_and_collide(motion)# allws the gravity to not affect movespeed
	move_and_slide() # without this no movement would happen


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _handle_jumping_state(delta):
	# If you're jumping, keep counting until you can no longer jump
	if current_jump_state == JumpState.JUMPING:
		elapsed_jump_time += delta
		# Fall if jumping for too long
		if elapsed_jump_time >= jump_duration:
			current_jump_state = JumpState.FALLING

	# Input
	if Input.is_action_just_pressed("jump"):
		if current_jump_state == JumpState.READY and is_on_floor():
			current_jump_state = JumpState.JUMPING
			#anim.play("Jump")
	if Input.is_action_just_released("jump"):
		if current_jump_state == JumpState.JUMPING:
			current_jump_state = JumpState.FALLING
# Reset state
	if current_jump_state == JumpState.FALLING and is_on_floor():
		current_jump_state = JumpState.READY
		elapsed_jump_time = 0.0    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("call")
	# player's display index
	set_z_index(4)
	
	_handle_jumping_state(delta)# inputs then
	match current_jump_state:#    the actuall math
		JumpState.READY, JumpState.FALLING:
			# Gravity is here
			velocity.y = min(velocity.y + GRAVITY * delta, MAX_FALLING_VELOCITY)
			if velocity.y >= -10:
				velocity.y = 1.01 * min(velocity.y + GRAVITY * delta, MAX_FALLING_VELOCITY)
			
		JumpState.JUMPING:
			#velocity.y = JUMP_PWR
			# or if you want to smooth/ease jump over time
			velocity.y =(JUMP_PWR * ease( elapsed_jump_time/jump_duration, 3.0)) * delta
			print("delta | jump | both")
			print(delta)
			print(JUMP_PWR * elapsed_jump_time/jump_duration)
			print((JUMP_PWR * elapsed_jump_time/jump_duration) * delta)
			print(velocity.y)
			# figure out whether you want to factor in "delta" or not there
		
	#simple inputs
	if Input.is_action_pressed("pause"):
		if !pause:
			pause = true
			print("true")
		else:
			pause = false
		#get_tree().quit()

	# Input
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = false
		velocity.x = MOVE_SPD
		
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = true
		velocity.x = -MOVE_SPD
		
	else:
		velocity.x = 0
	
	# animations
	if velocity.length() > 0 and is_on_floor():
		velocity = velocity.normalized() * MOVE_SPD
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("idle")
		
# bug hunting prints
	#print( delta)
	#print(velocity.x)
	#print(velocity.y)
	#print(is_on_floor())


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
