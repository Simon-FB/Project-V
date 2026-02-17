extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = 3000
	var input_direction = Input.get_vector("left","right","up","down")
	
	if Input.is_key_pressed(KEY_SHIFT):
		speed = 9000
	
	velocity = input_direction * speed * delta
	move_and_slide()
		
	pass
