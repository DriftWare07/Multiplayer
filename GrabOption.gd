extends InteractableOption
class_name GrabOption


func execute(executor: Node):
	
	if executor is Player and get_parent() is RigidBody3D:
		print("grabbed!")
		executor.anchorpoint.grab_anchorable(get_parent())
