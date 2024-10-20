extends RigidBody2D

@onready var move_right_force = Vector2(1500, 0)
@onready var move_left_force = Vector2(-1500, 0)
@onready var move_speed_max = 140

@onready var jump_force = Vector2(0, -18000)
@onready var can_jump = false

@onready var stuck_on_left_wall = false
@onready var stuck_on_right_wall = false

@onready var ray_left_foot = $Rays/RayLeftFoot
@onready var ray_right_foot = $Rays/RayRightFoot
@onready var ray_top_left_side = $Rays/RayTopLeftSide
@onready var ray_top_right_side = $Rays/RayTopRightSide
@onready var ray_bottom_left_side = $Rays/RayBottomLeftSide
@onready var ray_bottom_right_side = $Rays/RayBottomRightSide

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_state()
	
	process_input()
	
	if stuck_on_left_wall:
		self.apply_impulse(move_right_force, Vector2(0, 0))
	
	if stuck_on_right_wall:
		self.apply_impulse(move_left_force, Vector2(0, 0))
	
func process_input():
	if Input.is_action_pressed("move_right") and self.linear_velocity.x < move_speed_max:
		self.apply_impulse(move_right_force, Vector2(0, 0))
	
	if Input.is_action_pressed("move_left") and self.linear_velocity.x > -move_speed_max:
		self.apply_impulse(move_left_force, Vector2(0, 0))
	
	if Input.is_action_just_pressed("jump") and can_jump:
		self.apply_impulse(jump_force, Vector2(0, 0))

func set_state():
	
	# TODO - Implement Coyote Time here
	# Maybe by doing a counter where can_jump is set to false after a few frames of no foot collisions
	can_jump = is_on_floor()
	
	stuck_on_left_wall = (not is_on_floor()) and (ray_top_left_side.is_colliding() or ray_bottom_left_side.is_colliding())
	stuck_on_right_wall = (not is_on_floor()) and (ray_top_right_side.is_colliding() or ray_bottom_right_side.is_colliding())

func is_on_floor():
	return ray_left_foot.is_colliding() or ray_right_foot.is_colliding()
	
