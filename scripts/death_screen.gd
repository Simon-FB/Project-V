extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random_text = randi_range(0,9)
	match random_text:
		0:
			$TextureRect/Label.text = "No, not like this..."
		1:
			$TextureRect/Label.text = "Get up, you have much to do."
		2:
			$TextureRect/Label.text = "You lost a battle, but you are filled with determination."
		3:
			$TextureRect/Label.text = "Are you going to let them win?"
		4:
			$TextureRect/Label.text = "Arise hero, your time is not over yet."
		5:
			$TextureRect/Label.text = "Well, he warned you that this armor wasn't solid."
		6:
			$TextureRect/Label.text = "What's one more try?"
		7:
			$TextureRect/Label.text = "You've done better, show them."
		8:
			$TextureRect/Label.text = "Do you not remember...?"
		9:
			$TextureRect/Label.text = "You have a goal, let nothing stop you."
		_:
			print("Don't mess with my variables please")

func _on_button_pressed() -> void:
	world.reset_command = true
	queue_free()
