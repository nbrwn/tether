extends StaticBody2D
@export var max_tether_length = 40

var tether_segments = []
var tether_segment = preload("res://scenes/TetherSegment.tscn")
var reset_force_constant = .1

func _ready() -> void:
	generate_tether()
	
func _process(delta: float) -> void:
	var first_segment = tether_segments[0]
	var base = $TetherBase
	
	var base_distance = base.position.distance_to(first_segment.position)
	if base_distance > 0.1:
		var diff = base.position - first_segment.position
		var unit_vector = diff / (diff.length())
		first_segment.apply_impulse(reset_force_constant * unit_vector, Vector2(0, 0))
	
	for i in range(1, len(tether_segments)):
		var current_segment = tether_segments[i]
		var previous_segment = tether_segments[i-1]
		
		# Calc points
		var curr_pt = current_segment.position
		var prev_dir = Vector2(cos(previous_segment.rotation), sin(previous_segment.rotation))
		var prev_pt = previous_segment.position + (3 * prev_dir)
		
		var distance = curr_pt.distance_to(prev_pt)
		if distance > 0.1:
			var diff = curr_pt - prev_pt
			var unit_vector = diff / (diff.length())
			#var reset_force = (diff.length()) * reset_force_constant
			previous_segment.apply_impulse(reset_force_constant * unit_vector, (3 * prev_dir))
			
	var last_segment = tether_segments[len(tether_segments)-1]
	var head = $TetherHead
	
	var head_distance = head.position.distance_to(last_segment.position)
	if head_distance > 0.1:
		var diff = head.position - last_segment.position
		var unit_vector = diff / (diff.length())
		last_segment.apply_impulse(reset_force_constant * unit_vector, Vector2(0, 0))
	#var head_distance = $TetherHead.position.distance_to(tether_segments[max_tether_length - 1].position)
	#if distance > 4.1
		
	

func generate_tether() -> void:
	var previous_point = $TetherBase
	var offset = 0
	var step = 4
	for i in max_tether_length:
		#Create new tether_segment
		var tether_segment_instance = tether_segment.instantiate()
		tether_segments.append(tether_segment_instance)
		add_child(tether_segment_instance)
		
		#Move, Rotate, Pin new tether_segment
		#tether_segment_instance.rotation_degrees = -90
		tether_segment_instance.position = Vector2(offset, 0)
		#tether_segment_instance.get_node("SegmentPinJoint").node_a = previous_point.get_path()
		
		#Iterate
		previous_point = tether_segment_instance
		offset += step
	#Attach TetherHead to end of tether
	#$TetherHead.transform = Transform2D(0.0, Vector2(offset, 0))
	#tether_segments.append($TetherHead)
	#$TetherHead/HeadToSegmentPinJoint.node_a = previous_point.get_path()

	
	
	
