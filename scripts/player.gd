extends CharacterBody2D

class_name player_

var spawn_slash
var closest_target = world.center
var target_list = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Anim.play("idle_right")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if world.reset == true:
		queue_free()
	
	#GET POSITION
	Player.position = global_position
	
	#ANIM SPEED CHANGES
	$Anim.speed_scale = Player.anim_speed
	
	#BASE MOVEMENT
	var input_direction = Input.get_vector("left","right","up","down")
	velocity = input_direction * Player.base_speed * Player.speed_modifier * delta
	move_and_slide()
	
	#WALK AND IDLE
	match input_direction[0]:
		1.0: 
			$Anim.play("walk_right")
			Player.last_direction = "right"
		-1.0:
			$Anim.play("walk_left")
			Player.last_direction = "left"
		_:
			match input_direction[1]:
				1.0:
					$Anim.play("walk_down")
					Player.last_direction = "down"
					
				-1.0:
					$Anim.play("walk_up")
					Player.last_direction = "up"
				_: 
					if input_direction[0] > 0:
						if input_direction[1] > 0:
							$Anim.play("walk_down_right")
							Player.last_direction = "down_right"
						if input_direction[1] < 0:
							$Anim.play("walk_up_right")
							Player.last_direction = "up_right"
					if input_direction[0] < 0:
						if input_direction[1] > 0:
							$Anim.play("walk_down_left")
							Player.last_direction = "down_left"
						if input_direction[1] < 0:
							$Anim.play("walk_up_left")
							Player.last_direction = "up_left"
	#IDLE
					if input_direction[0] == 0.0 and input_direction[1] == 0.0:
						match Player.last_direction:
							"right":
								$Anim.play("idle_right")
							"left":
								$Anim.play("idle_left")
							"up":
								$Anim.play("idle_up")
							"down":
								$Anim.play("idle_down")
							"up_right":
								$Anim.play("idle_up_right")
							"up_left":
								$Anim.play("idle_up_left")
							"down_right":
								$Anim.play("idle_down_right")
							"down_left":
								$Anim.play("idle_down_left")
	
	#DASH (no iframes)
	if (Input.is_action_pressed("dash")
	and Player.unlock_dash
	and Player.can_dash 
	and not(Player.effect_list.has("slow"))
	and not Player.unlock_shadow_form):
		
		Player.effect_list.append("dash")
		
	#DEATH
	if Player.health < 1:
		queue_free()
		
		
		
	#ATTACK
	#slash
	
		#find closest target
	target_list = $slash_range.get_overlapping_bodies()
	target_list.erase(self)
	for i in target_list:
		if (i.global_position.distance_to(Player.position)
		< (closest_target.global_position.distance_to(Player.position))
		and i != self):
			closest_target = i
			
	if target_list == []:
		closest_target == world.center
		
		
		#trigger
	if (
	Input.is_action_pressed("attack") 
	and target_list 
	and closest_target != world.center
	and $slash_cooldown.is_stopped()):
		
		spawn_slash = preload("res://slash.tscn")
		spawn_slash = spawn_slash.instantiate()
		spawn_slash.global_position = Player.position
		add_child(spawn_slash)
		
		Ennemy.take_damage.append(closest_target)
		closest_target = world.center
		$slash_cooldown.start(1)
			
			
	#BLOCK / PARRY (deflects(animations reported to later :( ))
	#Ideas
	# shadow form has 3 charges
	# blocking consumes one charge and negates all damage (knocks u back a bit)
	# parry consumes no charges and counter attack / dodge / stuns ennemy

	# Parry vs ennemy
	# vs slime (green)
		# vs slimeball just dispawns
		# vs slime spike grab it, spin and slam the slime on a wall (big damage)
		# vs pounce dodges lets it splat on the ground (stuns)
		
	# vs squeleton archer
		# vs arrow grab it and return to sender
		# vs punch grabs arm and tries to judo throw but arm rips off (can't use bow anymore)
		# vs grapple hook grabs the hook and pull it, enemy falls on the ground (stuns)
		
	if (Input.is_action_pressed("block")):
		pass
