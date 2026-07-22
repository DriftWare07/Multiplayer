extends Node
class_name InteractableOption

@export var displayText = "Option"

signal executed

func execute(executor: Node):
	executed.emit()
