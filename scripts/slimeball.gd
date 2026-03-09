extends CharacterBody2D

func _ready() -> void:
	$Slimeball_anim.play("launched")
	visible = false


func _physics_process(delta: float) -> void:
	if Ennemy.slime_ball_launching == true:
		$Slimeball.visible = true
		$Slimeball.velocity = to_local(Player.position).normalized() * delta * Ennemy.slime_ball_speed
		$Slimeball.move_and_slide()
		Ennemy.slime_ball_launching = false
