extends Node2D
var had_slow
var had_dash

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#Effects
	if Player.effect_list.has("slow"):
		if not(had_slow):
			Player.speed_modifier /= 2
			Player.anim_speed = 0.5
			$Slow_time.start(1)
			had_slow = true
			Player.effect_list.erase("dash")
			Player.can_dash = false
			$Dash_Cooldown.start(2)
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
