extends CharacterBody2D

var hostile = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Anim.play("idle")
	
	var random = RandomNumberGenerator.new()
	random.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	# HOSTILE PATHFINDING (basic)
	if hostile == true:
		$Pathfinder.target_position = Player.position
		$Pathfinder.get_next_path_position()
		var next_point = to_local($Pathfinder.get_current_navigation_path()[1]).normalized()
		
		velocity = next_point * delta * Ennemy.slime_speed
		move_and_slide()
		
		#attack
		if $Pathfinder. distance_to_target() < 100:
			if $Attack_delay.is_stopped():
				$Attack_delay.start(randi() % 6)
				Ennemy.slime_ball_launching = true


func _on_aggro_radius_body_entered(body: Node2D) -> void:
	if body is player_:
		hostile = true
		
