extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var arm_right = $skeleton/hip/chest/arm_right
@onready var arm_left = $skeleton/hip/chest/arm_left

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	arm_follow() # Make the arms follow the mouse
	
	movement_process(delta)
	

func arm_follow():
	var mouse_pos = get_global_mouse_position() # Get the mouse position
	
	# Get the angle to the mouse position and subtract the bone angle from it to remove the offset
	var arm_right_angle = get_angle_to(mouse_pos) - arm_right.get_bone_angle()
	var arm_left_angle = get_angle_to(mouse_pos) - arm_left.get_bone_angle()
	
	# Finally roatate the arms
	arm_right.rotation = arm_right_angle
	arm_left.rotation = arm_left_angle

func movement_process(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jumping
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
