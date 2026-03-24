extends CharacterBody2D

var vector
var got_vector = false
var splatted = false
var colided_object
var random_speed_modifier = randf_range(0.8,1.2)
func _ready() -> void:
	$Slimeball_anim.play("launched")
	$Decay_time.start(15)

func _physics_process(delta: float) -> void:
	if world.reset == true:
		queue_free()
	
	if got_vector == false:
		vector = to_local(Player.position).normalized()
		vector[0] += randf_range(-0.2,0.2)
		vector[1] += randf_range(-0.2,0.2)
		got_vector = true
	
	
	velocity = vector * delta * (Ennemy.slimeball_speed * random_speed_modifier)
	colided_object = move_and_collide(velocity)
	
	
	#ON WALL COLLISION
	if colided_object:
		if splatted == false:
			vector = Vector2(0,0)
			$Slimeball_anim.play("splat")
			splatted = true
	
			
func _on_splat_zone_body_entered(body: Node2D) -> void:
	if body is player_ and !Player.effect_list.has("slow"):
		splatted = true
		vector = Vector2(0,0)
		Player.effect_list.append("slow")
		
		if !$Slimeball_anim.animation == "splat":
			$Slimeball_anim.play("splat")
		
	
func _on_splat_zone_body_exited(body: Node2D) -> void:
	if body is player_ and !Player.effect_list.has("slow") and splatted == true:
		Player.effect_list.append("slow")
		


func _on_decay_time_timeout() -> void:
	queue_free()
