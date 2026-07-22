extends RayCast3D
class_name Interactor3D

@export var parent : Player

@onready var context = %contextMenu
@onready var context_cont = %contextCont

var obj : Interactable3D
var idx = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_colliding():
		if get_collider() is Interactable3D and get_collider() != parent.anchorpoint.anchorable:
			obj = get_collider()
			
			if Input.is_action_just_released("mwheel_down"):
				idx += 1
			if Input.is_action_just_released("mwheel_up"):
				idx -= 1
			
			idx = wrapi(idx, 0, obj.options.size())
			
			context_cont.text = ""
			var i = 0
			for opt in obj.options:
				
				if i == idx:
					context_cont.text += "[color=yellow]"+opt.displayText+"[/color]\n"
				else:
					context_cont.text += opt.displayText+"\n"
				
				i+= 1
			
			context.show()
			context.position = get_viewport().get_camera_3d().unproject_position(obj.position)
			if Input.is_action_just_pressed("grab"):
				obj.activate_option(idx, parent)
		else:
			context.hide()
	else:
		idx = 0
		context.hide()
	
	if Input.is_action_just_pressed("ungrab"):
		parent.anchorpoint.drop_anchorable()
