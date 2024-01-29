extends AnimatedSprite2D
class_name Rice

var plantable: bool = true
var holdable: bool = true
var harvestable: bool = false
var states: int = 3
var mutateable: bool = false
var crossbreedable: String = "Carrot"

var on_grow_value: int = 15
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

func grow():
	if frame != states:
		frame += 1
		
		if frame == states:
			harvestable = true

func harvest():
	frame = states + 1
	plantable = false
	holdable = true
	picked_up = true
	value = on_grow_value

func crossbreed(plant: String):
	if plant == crossbreedable:	
		var current_frame = frame
		animation = "golden"
		frame = current_frame
		on_grow_value = 25

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
