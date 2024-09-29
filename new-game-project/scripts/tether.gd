extends StaticBody2D
@export var max_tether_length = 10
var tether_segments = []

func _ready() -> void:
	generate_tether()
	
func _process(delta: float) -> void:
	for segment in tether_segments:
		print(segment.position)
func generate_tether() -> void:
	var previous_point = $TetherBase
	var tether_segment = load("res://scenes/TetherSegment.tscn")
	var offset = 0
	for i in max_tether_length:
		var tether_segment_instance = tether_segment.instantiate()
		tether_segment_instance.get_node("SegmentPinJoint").node_a = previous_point.get_path()
		add_child(tether_segment_instance)
		offset += 1
		tether_segment_instance.transform = Transform2D(0.0, Vector2(0, offset))
		tether_segments.append(tether_segment_instance)
		previous_point = tether_segment_instance
	for segment in tether_segments:
		print(segment.position)
	
	
	
