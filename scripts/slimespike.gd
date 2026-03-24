extends CharacterBody2D
var start_anim = false
var inacuracy = randf_range(1.35,1.5)
var in_hitbox = false
var active = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$anim.play("attack")
	

func _process(_delta: float) -> void:
	if world.reset == true:
		queue_free()
	
	
	rotate(get_angle_to(Player.position)+inacuracy)
	if $anim.frame == 15 and in_hitbox and active == true:
		Player.effect_list.append("take_damage")
		active = false

func _on_hitbox_area_entered(_area: Area2D) -> void:
	in_hitbox = true
	
func _on_hitbox_area_exited(_area: Area2D) -> void:
	in_hitbox = false
	
func _on_anim_animation_finished() -> void:
	in_hitbox = false
	queue_free()
