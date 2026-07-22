extends Label3D
class_name NameTag

@export var id : int
var sid
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	billboard = BaseMaterial3D.BILLBOARD_ENABLED
	id = get_parent().name.to_int()
	
	sid = Networking.peer.get_steam_id_for_peer_id(id)
	
	
	if !get_parent().authority: text = Steam.getPersonaName()



func setNameFromPersona(steam_id: int, flags: int = 0):
	#print("got name")
	if steam_id != sid: return
	#if steam_id == id:
	Steam.requestUserInformation(sid, true)
	var n = Steam.getFriendPersonaName(steam_id)
	
	if n == "": text = "Loading"
	else: text = n
	#print(Steam.getFriendPersonaName(steam_id))
	
