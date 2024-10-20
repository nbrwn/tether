'''extends RigidBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

func _integrate_forces(state):
	print("hello")
	var direction := Input.get_axis("ui_left", "ui_right")
	print(direction)
	if direction != 0:
		apply_central_force(direction * SPEED * Vector2.RIGHT * state.get_step())
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		apply_impulse(Vector2.ZERO,  direction* JUMP_VELOCITY *Vector2.RIGHT*state.get_step())
'''
extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var IS_TETHERED = true


func _physics_process(delta: float) -> void:
	#Do tether logic
	if IS_TETHERED:
		pass
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
