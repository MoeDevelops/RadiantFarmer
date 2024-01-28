extends AnimatedSprite2D
class_name Carrot

var plantable: bool = true
var holdable: bool = true
var harvestable: bool = false

var value: int = 5
var player: Player = null
var picked_up: bool = false

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player.interact.connect(interact)

func _on_area_2d_body_exited(body):
	if body is Player:
		player.interact.disconnect(interact)
		player = null

func interact(item):
	if holdable:
		if item == null:
			player.item = self
			picked_up = true
		elif item == self:
			player.item = null
			picked_up = false

func _physics_process(_delta):
	if picked_up == true:
		position = player.marker.global_position
		z_index = 10
	else:
		var new_position = Vector2(int(position.x / 16) * 16 + 8, int(position.y / 16) * 16 + 8)
		position = new_position
		z_index = 0
