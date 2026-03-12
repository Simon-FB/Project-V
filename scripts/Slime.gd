extends CharacterBody2D

var hostile = false
var spawn_slimeball = preload("res://slimeball.tscn")
var slimeball_instance
var next_point
var new_delay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Anim.play("idle")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	# HOSTILE PATHFINDING (basic)
	if hostile == true:
		$Pathfinder.target_position = Player.position
		$Pathfinder.get_next_path_position()
		next_point = to_local($Pathfinder.get_current_navigation_path()[1]).normalized()
		
		velocity = next_point * delta * Ennemy.slime_speed
		move_and_slide()
		
		#attack
		if $Pathfinder.distance_to_target() > 50:
			if $Attack_delay.is_stopped():
				new_delay = randi() % 6
				while new_delay < 3 :
					new_delay = randi() % 6
				$Attack_delay.start(new_delay)
				shoot_slimeball()
				
func shoot_slimeball() -> void:
	
	slimeball_instance = spawn_slimeball.instantiate()
	owner.add_child(slimeball_instance)
	slimeball_instance.global_position = global_position
	

func _on_aggro_radius_body_entered(body: Node2D) -> void:
	if body is player_:
		hostile = true
