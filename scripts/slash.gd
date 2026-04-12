extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("attack")

func _process(_delta: float) -> void:
	if world.reset == true:
		queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
