extends AnimatedSprite2D

func _on_sell_chest_area_body_entered(body: Node2D):
	if body is Player:
		play("Open")


func _on_sell_chest_area_body_exited(body: Node2D):
	if body is Player:
		play_backwards("Open")
