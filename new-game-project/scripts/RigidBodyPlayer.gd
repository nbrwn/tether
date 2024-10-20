extends RigidBody2D

@onready var move_right_force = Vector2(1500, 0)
@onready var move_left_force = Vector2(-1500, 0)
@onready var move_speed_max = 140
@onready var jump_force = Vector2(0, -18000)

@onready var ray_right_foot = $RayRightFoot
@onready var ray_left_foot = $RayLeftFoot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if Input.is_action_pressed("move_right") and self.linear_velocity.x < move_speed_max:
		self.apply_impulse(move_right_force, Vector2(0, 0))
	
	if Input.is_action_pressed("move_left") and self.linear_velocity.x > -move_speed_max:
		self.apply_impulse(move_left_force, Vector2(0, 0))
	
	if Input.is_action_just_pressed("jump") and (ray_left_foot.is_colliding() or ray_right_foot.is_colliding()):
		self.apply_impulse(jump_force, Vector2(0, 0))
