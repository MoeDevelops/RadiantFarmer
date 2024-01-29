extends AnimatedSprite2D

var player: Player = null
@export var world: World = null

func _on_sell_chest_area_body_entered(body):
	if body is Player:
		player = body
		player.interact.connect(interact)
		play("Open")

func _on_sell_chest_area_body_exited(body):
	if body is Player:
		play_backwards("Open")
		player.interact.disconnect(interact)
		player = null

func interact(item):
	if item != null and "value" in item and item.value is int:
		world.money += item.value
		world.score += item.value
		world.update_label()
		item.queue_free()
