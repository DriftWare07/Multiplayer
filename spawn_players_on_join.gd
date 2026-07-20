extends Node2D

const PLAYER = preload("uid://cobjcpic7a2lq")

@export var spawn : Node2D

var players: Array[CharacterBody2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Networking.host_created.connect(on_host_created)


func on_host_created():
	spawn_player(multiplayer.get_unique_id())
	multiplayer.peer_connected.connect(spawn_player)

func spawn_player(peer_id: int):
	var new_player = PLAYER.instantiate() as CharacterBody2D
	new_player.name = str(peer_id)
	add_child(new_player)
	initialize_player(new_player)

func initialize_player(player: CharacterBody2D):
	player.position = spawn.position
	for other in players:
		player.add_collision_exception_with(other)
	players.append(player)


func host_new_lobby() -> void:
	Networking.host_lobby()

func _on_object_spawned(node: Node):
	#check if the thing added is a player, then add said player to array
	if node is CharacterBody2D:
		initialize_player(node)
