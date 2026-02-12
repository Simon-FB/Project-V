extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed = 100
	
	if Input.is_key_pressed(KEY_SHIFT):
		speed = 300

	if Input.is_key_pressed(KEY_Z):
		$".".position.y -= speed * delta
	if Input.is_key_pressed(KEY_S):
		$".".position.y += speed * delta
	if Input.is_key_pressed(KEY_Q):
		$".".position.x -= speed * delta
	if Input.is_key_pressed(KEY_D):
		$".".position.x += speed * delta
		
	pass
