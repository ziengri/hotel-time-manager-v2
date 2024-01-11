extends AnimatedSprite2D


func _on_animation_finished():
	if animation == "1":
		play("2")
