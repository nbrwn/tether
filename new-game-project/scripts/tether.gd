extends StaticBody2D
@export var max_tether_length = 10
var tether_segments = []

func _ready() -> void:
	generate_tether()
	
func _process(delta: float) -> void:
	for segment in tether_segments:
		#print(segment.position)
		pass

func generate_tether() -> void:
	var previous_point = $TetherBase
	var tether_segment = load("res://scenes/TetherSegment.tscn")
	var offset = 0
	for i in max_tether_length:
		var tether_segment_instance = tether_segment.instantiate()
		tether_segment_instance.get_node("SegmentPinJoint").node_a = previous_point.get_path()
		add_child(tether_segment_instance)
		offset += 10
		tether_segment_instance.transform = Transform2D(0.0, Vector2(offset, 0))
		tether_segment_instance.rotation_degrees = 90
		tether_segments.append(tether_segment_instance)
		previous_point = tether_segment_instance
	$TetherHead.transform = Transform2D(0.0, Vector2(offset + 10, 0))
	$TetherHead/HeadToSegmentPinJoint.node_a = previous_point.get_path()

	
	
	
