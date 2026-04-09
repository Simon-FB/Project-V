extends CharacterBody2D
var correction = randf_range(1.35,1.5)
var in_hitbox = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$anim.play("attack")

func _process(_delta: float) -> void:
	if world.reset == true:
		queue_free()
		
	in_hitbox = global_position.distance_to(Player.position) < 58

	rotate(get_angle_to(Player.position)+correction)
	if $anim.frame == 15 and in_hitbox:
		Player.effect_list.append("take_damage")
	
func _on_anim_animation_finished() -> void:
	in_hitbox = false
	queue_free()
