extends CharacterBody2D

class_name player_

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
	if Input.is_key_pressed(KEY_SPACE) and Player.can_dash:
		Player.effect_list.append("dash")
		
	#DEATH
	if Player.health < 1:
		queue_free()
	#ATTACK
	
			
	#BLOCK / PARRY (crazy ass deflects)
	#Ideas
	# shield has 3 charges
	# blocking consumes one charge and negates all damage (knocks u back a bit)
	# parry consumes no charges and counter attack / dodge / stuns ennemy

	# Parry vs ennemy
	# vs slime (green)
		# vs slimeball just dispawns
		# vs slime whip grab it, spin and slam the slime on a wall (big damage)
		# vs pounce dodges lets it splat on the ground (stuns)
		
	# vs squeleton archer
		# vs arrow grab it and return to sender
		# vs punch grabs arm and tries to judo throw but arm rips off (can't use bow anymore)
		# vs grapple hook grabs the hook and pull it, enemy falls on the ground (stuns)
		
