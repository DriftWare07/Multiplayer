extends AnimationTree

@onready var parent : Player = get_parent()

var speed = 0.0
var dir = Vector2.ZERO
var air = 0.0
var crouch = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not parent.authority: return
	speed = lerp(speed, parent.velocity.length(), delta*5)
	dir.x = lerp(dir.x, parent._input_direction.x, delta*10)
	dir.y = lerp(dir.y, parent._input_direction.y, delta*10)
	
	speed = clamp(speed, 0.0, 1.0)
	
	if parent.is_on_floor():
		air = lerp(air, 0.0, delta*10)
	else:
		air = lerp(air, 1.0, delta*10)
	
	if Input.is_action_pressed("crouch"):
		crouch = lerp(crouch, 1.0, delta*10)
	else:
		crouch = lerp(crouch, 0.0, delta*10)
	
	self["parameters/run/blend_amount"] = speed
	self["parameters/direction/blend_position"] = dir
	self["parameters/crouch/blend_position"] = dir
	self["parameters/inair/blend_amount"] = air
	self["parameters/crouching/blend_amount"] = crouch
	
