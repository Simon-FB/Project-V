extends CharacterBody2D

var vector
var got_vector = false

func _ready() -> void:
	$Slimeball_anim.play("launched")
	$Decay_time.start(5)

func _physics_process(delta: float) -> void:
	if got_vector == false:
		vector = to_local(Player.position).normalized()
		got_vector = true
	
	#vector[0] = vector[0] + randf_range(-0.3,0.3)
	#vector[1] = vector[1] + randf_range(-0.3,0.3)
	velocity = vector * delta * Ennemy.slimeball_speed
	move_and_collide(velocity)
	
	if $Decay_time.is_stopped():
		queue_free()
