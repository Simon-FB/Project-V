extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("checkpoint" + str(Player.checkpoint))
	if body is player_:
		Player.checkpoint = get_parent().name.to_int()
		print(Player.checkpoint)
