extends CharacterBody2D

var vector
var got_vector = false
var splatted = false
var player_slowed = false
var colided_object
var dash_cancel = false

func _ready() -> void:
	$Slimeball_anim.play("launched")
	$Decay_time.start(10)

func _physics_process(delta: float) -> void:
	if got_vector == false:
		vector = to_local(Player.position).normalized()
		got_vector = true
	
	#vector[0] = vector[0] + randf_range(-0.3,0.3)
	#vector[1] = vector[1] + randf_range(-0.3,0.3)
	velocity = vector * delta * Ennemy.slimeball_speed
	colided_object = move_and_collide(velocity)
	
	if colided_object:
		if splatted == false:
			vector = Vector2(0,0)
			$Slimeball_anim.play("splat")
			splatted = true
			
	print(Player.speed)



func _on_splat_zone_body_entered(body: Node2D) -> void:

	if splatted == true and body is player_ and player_slowed == false:
		Player.speed -=1800
		player_slowed = true
		if Player.dash_active:
			Player.dash_canceled = true
			Player.speed -= Player.dash_bonus

func _on_splat_zone_body_exited(body: Node2D) -> void:
	if body is player_ and player_slowed == true:
		$Slow_time.start(2)
	
func _on_slow_time_timeout() -> void:
	Player.speed +=1800
	player_slowed = false
	if Player.dash_canceled == true:
		Player.dash_canceled == false
		Player.speed += Player.dash_bonus

func _on_decay_time_timeout() -> void:
	queue_free()
