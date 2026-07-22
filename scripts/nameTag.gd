extends Label3D
class_name NameTag

@export var id : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	id = get_parent().name.to_int()
	Steam.persona_state_change.connect(setNameFromPersona)

func setNameFromPersona(steam_id: int, flags: int):
	print("got name")
	#if steam_id == id:
	text = Steam.getFriendPersonaName(id)
