extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Slime_Anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_aggro_radius_body_entered(body: Node2D) -> void:
	if body is player_:
		pass
