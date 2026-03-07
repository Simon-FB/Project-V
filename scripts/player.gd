extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player_Anim.play("idle_down_right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# MOVEMENT
	var speed = 3000
	var input_direction = Input.get_vector("left","right","up","down")
	
	#if Input.is_key_pressed(KEY_SHIFT):
	#	speed = 9000
	
	velocity = input_direction * speed * delta
	move_and_slide()
	
	
	# SPRITE CHANGE
	Player.get_property_list()

	#WALK
	match input_direction[0]:
		1.0: 
			$Player_Anim.play("walk_right")
			Player.last_direction = "right"
		-1.0:
			$Player_Anim.play("walk_left")
			Player.last_direction = "left"
		_:
			match input_direction[1]:
				1.0:
					$Player_Anim.play("walk_down")
					Player.last_direction = "down"
					
				-1.0:
					$Player_Anim.play("walk_up")
					Player.last_direction = "up"
				_: 
					if input_direction[0] > 0:
						if input_direction[1] > 0:
							$Player_Anim.play("walk_down_right")
							Player.last_direction = "down_right"
						if input_direction[1] < 0:
							$Player_Anim.play("walk_up_right")
							Player.last_direction = "up_right"
					if input_direction[0] < 0:
						if input_direction[1] > 0:
							$Player_Anim.play("walk_down_left")
							Player.last_direction = "down_left"
						if input_direction[1] < 0:
							$Player_Anim.play("walk_up_left")
							Player.last_direction = "up_left"
	#IDLE
					if input_direction[0] == 0.0 and input_direction[1] == 0.0:
						match Player.last_direction:
							"right":
								$Player_Anim.play("idle_right")
							"left":
								$Player_Anim.play("idle_left")
							"up":
								$Player_Anim.play("idle_up")
							"down":
								$Player_Anim.play("idle_down")
							"up_right":
								$Player_Anim.play("idle_up_right")
							"up_left":
								$Player_Anim.play("idle_up_left")
							"down_right":
								$Player_Anim.play("idle_down_right")
							"down_left":
								$Player_Anim.play("idle_down_left")
								
