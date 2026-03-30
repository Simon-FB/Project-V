extends Node2D
var had_slow = false
var had_dash = false 
var had_invincible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if world.reset == true:
		queue_free()
	
	#Effects
	if Player.effect_list.has("slow"):
		if not(had_slow):
			Player.speed_modifier /= 2
			Player.anim_speed = 0.5
			$Slow_time.start(3)
			had_slow = true
	else:
		if had_slow:
			Player.speed_modifier *= 2
			Player.anim_speed = 1
		had_slow = false
	
	if Player.effect_list.has("dash"):
		if not(had_dash) and not(had_slow):
			Player.speed_modifier *= 3
			Player.anim_speed = 2
			$Dash_time.start(0.5)
			had_dash = true
			Player.can_dash = false
	else:
		if had_dash:
			Player.speed_modifier /= 3
			Player.anim_speed = 1
		had_dash = false
		
	
	if Player.effect_list.has("invincible"):
		if not(had_invincible):
			$Invincible_time.start(1)
		had_invincible = true
	else:
		had_invincible = false
	
	if Player.effect_list.has("take_damage"):
		if not Player.effect_list.has("invincible"):
			Player.health -= 1
			Player.effect_list.append("invincible")
		Player.effect_list.erase("take_damage")


	
# EFFECT OVER
func _on_dash_time_timeout() -> void:
	for i in len(Player.effect_list):
		Player.effect_list.erase("dash")
	$Dash_Cooldown.start(2)

func _on_dash_cooldown_timeout() -> void:
	Player.can_dash = true

func _on_slow_time_timeout() -> void:
	for i in len(Player.effect_list):
		Player.effect_list.erase("slow")


func _on_invincibility_time_timeout() -> void:
	for i in len(Player.effect_list):
		Player.effect_list.erase("invincible")
