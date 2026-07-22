extends Label3D
class_name NameTag

@export var id : int
var sid
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	id = get_parent().name.to_int()
	
	sid = Networking.peer.get_steam_id_for_peer_id(id)
	
	Steam.persona_state_change.connect(setNameFromPersona)
	Steam.requestUserInformation(sid, true)



func setNameFromPersona(steam_id: int, flags: int = 0):
	print("got name")
	#if steam_id == id:
	Steam.requestUserInformation(sid, true)
	var n = Steam.getFriendPersonaName(id)
	
	if n == "": text = "Loading"
	else: text = n
	print(Steam.getFriendPersonaName(id))
	print(steam_id)
