extends CharacterBody2D

var vector
var got_vector = false
var splatted = false
var colided_object
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
			
func _on_splat_zone_body_entered(body: Node2D) -> void:
	if body is player_ and !Player.effect_list.has("slow") and splatted == true:
		Player.effect_list.append("slow")
	
func _on_splat_zone_body_exited(body: Node2D) -> void:
	if body is player_ and !Player.effect_list.has("slow") and splatted == true:
		Player.effect_list.append("slow")
		


func _on_decay_time_timeout() -> void:
	queue_free()
