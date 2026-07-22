extends RigidBody3D
class_name Interactable3D

var options : Array[InteractableOption]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_children():
		if child is InteractableOption:
			options.append(child)



func activate_option(idx: int, activator: Node):
	options[idx].execute(activator)
