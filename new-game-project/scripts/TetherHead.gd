extends RigidBody2D
func _on_head_area_body_entered(body: Node2D) -> void:
	if body.name == 'Player':
		$HeadPinJoint.node_b = body.get_path()
