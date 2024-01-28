extends AnimatedSprite2D
class_name Soil

var holdable = false
var plant: AnimatedSprite2D = null
var has_uranium: bool = false
@onready var uranium_light: PointLight2D = $UraniumLight
@onready var marker: Marker2D = $Marker2D

var player: Player = null

func _on_area_2d_body_entered(body):
	if body is Player:
		player = body
		player.interact.connect(interact)

func _on_area_2d_body_exited(body):
	if body is Player:
		player.interact.disconnect(interact)
		player = null

func interact(item):
	if item == null:
		return
	
	if item is Uranium:
		if !has_uranium:
			item.queue_free()
			play("default")
			set_has_uranium(true)
		else:
			item.interact(null)
	elif "plantable" in item and item.plantable == true:
		item.global_position = marker.global_position
		item.holdable = false
		plant = item
		plant.frame = 1
		

func set_has_uranium(b: bool):
	has_uranium = b
	uranium_light.enabled = b
