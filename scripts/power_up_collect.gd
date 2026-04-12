extends Node2D



func _on_collision_body_entered(body: Node2D) -> void:
	if body is player_:
		Player.power_up_count += 1
		print(Player.power_up_count)
		queue_free()
