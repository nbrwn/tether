extends RigidBody2D
var attached = false
var char = null

func _process(delta: float) -> void:
	if attached: 
		self.position = char.position


func _on_head_area_body_entered(body: Node2D) -> void:
	if body.name == 'RigidBodyChar':
		print('attach tether')
		attached = true
		char = body
		#$HeadToPlayerPinJoint.node_b = body.get_path()
		
