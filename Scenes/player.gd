extends CharacterBody2D

@export var speed = 500.0
@export var accel = 50.0
@export var decel = 100.0

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if dir.length() > 0.0:
		velocity = velocity.move_toward(dir*speed, delta*accel)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta*decel)
	
	move_and_slide()
