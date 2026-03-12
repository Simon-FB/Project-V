extends Node

var spawn_player = preload("res://player.tscn")
var spawn_slime = preload("res://slime.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	spawn_player = spawn_player.instantiate()
	spawn_player.global_position = Vector2(200.0,280.0)
	add_child(spawn_player)

	
	spawn_slime = spawn_slime.instantiate()
	spawn_slime.global_position = Vector2(312.0,312.0)
	add_child(spawn_slime)
