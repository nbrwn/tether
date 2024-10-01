extends StaticBody2D
@export var max_tether_length = 20
var tether_segments = []
var tether_segment = preload("res://scenes/TetherSegment.tscn")

func _ready() -> void:
	generate_tether()
	
func _process(delta: float) -> void:
	for segment in tether_segments:
		#print(segment.position)
		pass

func generate_tether() -> void:
	var previous_point = $TetherBase
	var offset = 4
	var step = 8
	for i in max_tether_length:
		#Create new tether_segment
		var tether_segment_instance = tether_segment.instantiate()
		tether_segments.append(tether_segment_instance)
		add_child(tether_segment_instance)
		
		#Move, Rotate, Pin new tether_segment
		tether_segment_instance.rotation_degrees = -90
		tether_segment_instance.position = Vector2(offset, 0)
		tether_segment_instance.get_node("SegmentPinJoint").node_a = previous_point.get_path()
		
		#Iterate
		previous_point = tether_segment_instance
		offset += step
	#Attach TetherHead to end of tether
	$TetherHead.transform = Transform2D(0.0, Vector2(offset, 0))
	$TetherHead/HeadToSegmentPinJoint.node_a = previous_point.get_path()

	
	
	
