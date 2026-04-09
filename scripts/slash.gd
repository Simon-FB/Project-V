extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("spawned")
	$AnimatedSprite2D.play("attack")
	print($AnimatedSprite2D.animation)

func _process(_delta: float) -> void:
	print($AnimatedSprite2D.frame)
	if world.reset == true:
		queue_free()

func _on_anim_animation_finished() -> void:
	queue_free()
