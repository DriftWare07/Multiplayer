extends Node3D
class_name AnchorPoint

@export var anchorable : RigidBody3D

@export var stiffness = 10_000.0
@export var damping = 100.0
@export var break_distance = 2.0

@export var angular_stiffness = 500.0

var recieved = false

signal grabbed
signal dropped
signal break_drop

func _physics_process(delta: float) -> void:
	if !anchorable: return
	anchorable.apply_central_force(hookes_law(global_position-anchorable.global_position, anchorable.linear_velocity, stiffness, damping))
	anchorable.apply_torque(hookes_law((global_rotation)-(anchorable.global_rotation), anchorable.angular_velocity, angular_stiffness, damping))
	
	if not recieved and anchorable.global_position.distance_to(global_position) < 2.0:
		recieved = true
	
	if recieved and anchorable.global_position.distance_to(global_position) > break_distance:
		drop_anchorable(true)

@rpc("any_peer")
func hookes_law(displacement: Vector3, current_velocity: Vector3, stiffness: float, damping: float) -> Vector3:
	return (stiffness * displacement) - (damping * current_velocity)

@rpc("any_peer")
func grab_anchorable(anch : RigidBody3D):
	recieved = false
	anchorable = anch
	grabbed.emit()

@rpc("any_peer")
func drop_anchorable(broken = false):
	
	if anchorable != null:
		if broken:
			break_drop.emit()
		else: 
			dropped.emit()
	
	recieved = false
	anchorable = null
	
	
	

@rpc("any_peer")
func destroy_anchorable():
	if anchorable != null:
		var a = anchorable
		drop_anchorable()
		a.queue_free()
