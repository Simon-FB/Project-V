extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle_down_right")
	pass # Replace with function body.


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
	var last_direction
	print(input_direction)
	#WALK
	match input_direction[0]:
		1.0: 
			$AnimatedSprite2D.play("walk_right")
			last_direction = "right"
		-1.0:
			$AnimatedSprite2D.play("walk_left")
			last_direction = "left"
		_:
			match input_direction[1]:
				1.0:
					$AnimatedSprite2D.play("walk_down")
					last_direction = "down"
				-1.0:
					$AnimatedSprite2D.play("walk_up")
					last_direction = "up"
				_: 
					if input_direction[0] > 0:
						if input_direction[1] > 0:
							$AnimatedSprite2D.play("walk_down_right")
							last_direction = "down_right"
						if input_direction[1] < 0:
							$AnimatedSprite2D.play("walk_up_right")
							last_direction = "up_right"
					if input_direction[0] < 0:
						if input_direction[1] > 0:
							$AnimatedSprite2D.play("walk_down_left")
							last_direction = "down_left"
						if input_direction[1] < 0:
							$AnimatedSprite2D.play("walk_up_left")
							last_direction = "up_left"
	#IDLE
					if input_direction[0] == 0.0 and input_direction[1] == 0.0:
						match last_direction:
							"right":
								$AnimatedSprite2D.play("idle_right")
							"left":
								$AnimatedSprite2D.play("idle_left")
							"up":
								$AnimatedSprite2D.play("idle_up")
							"down":
								$AnimatedSprite2D.play("idle_down")
							"up_right":
								$AnimatedSprite2D.play("idle_up_right")
							"up_left":
								$AnimatedSprite2D.play("idle_up_left")
							"down_right":
								$AnimatedSprite2D.play("idle_down_right")
							"down_left":
								$AnimatedSprite2D.play("idle_down_left")
								
