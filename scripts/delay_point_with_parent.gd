extends Node
class_name DelayPointWithParent


@onready var parent : Node3D = get_parent()
@onready var mp : Node3D = parent.get_parent()
@export var turn_speed = 10.0

@export var offset = Vector3.ZERO

func _ready() -> void:
	parent.top_level = true

func _process(delta: float) -> void:
	parent.rotation.x = lerp_angle(parent.rotation.x, mp.rotation.x, delta* turn_speed)
	parent.rotation.z = lerp_angle(parent.rotation.z, mp.rotation.z, delta* turn_speed)
	parent.rotation.y = lerp_angle(parent.rotation.y, mp.rotation.y, delta* turn_speed)
	
	
	
	parent.global_position = mp.global_position
