extends Node

var spawn_player
var load_effect_maneger
var spawn_slime
var load_deathscreen 
var deathscreen_loaded
var spawn_powerup
var finalscreen_loaded
var load_finalscreen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world_init()

	for i in range($Spawnpoints/Powerup_spawnpoint.get_child_count()):
		spawn_powerup = preload("res://power_up.tscn")
		spawn_powerup = spawn_powerup.instantiate()
		spawn_powerup.global_position = ($Spawnpoints/Powerup_spawnpoint
			.get_child(i).global_position)
		add_child(spawn_powerup)

	
func _process(_delta: float) -> void:
	if Player.health < 1 and not(deathscreen_loaded):
		load_deathscreen = preload("res://death_screen.tscn")
		load_deathscreen = load_deathscreen.instantiate()
		add_child(load_deathscreen)
		deathscreen_loaded = true
		
	if Player.power_up_count == 8 and not(finalscreen_loaded):
		load_finalscreen = preload("res://final_screen.tscn")
		load_finalscreen = load_finalscreen.instantiate()
		add_child(load_finalscreen)
		finalscreen_loaded = true
		
	if world.reset_command:
		world.reset_command = false
		world_init()
	

func world_init():
	Player.health = 1
	Player.effect_list = []
	deathscreen_loaded = false
	world.reset = true
	world.reset_command = false
	$world_reset_timer.start(0.1)
	

func _on_world_reset_timer_timeout() -> void:
	world.reset = false

	spawn_player = preload("res://player.tscn")
	spawn_player = spawn_player.instantiate()
	spawn_player.global_position = (
		$Spawnpoints/Player_spawnpoints
		.get_child(Player.checkpoint)
		.global_position
		)
	add_child(spawn_player)
	
	load_effect_maneger = preload("res://effect_manager.tscn")
	load_effect_maneger = load_effect_maneger.instantiate()
	add_child(load_effect_maneger)
	
	
	for i in range($Spawnpoints/Slime_spawnpoints.get_child_count()):
		spawn_slime = preload("res://slime.tscn")
		spawn_slime = spawn_slime.instantiate()
		spawn_slime.global_position = ($Spawnpoints/Slime_spawnpoints
			.get_child(i).global_position)
		add_child(spawn_slime)
		
