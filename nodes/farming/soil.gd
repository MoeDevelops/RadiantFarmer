extends AnimatedSprite2D
class_name Soil

var holdable = false
var plant: AnimatedSprite2D = null
var has_uranium: bool = false
@onready var uranium_light: PointLight2D = $UraniumLight
@onready var marker: Marker2D = $Marker2D
@export var world: World = null

var player: Player = null

func _ready():
	world.new_day.connect(_on_new_day)

func _on_new_day():
	if plant == null:
		return
	
	if plant.mutateable == true and has_uranium:
		plant.mutate()
		set_has_uranium(false)
	elif plant.crossbreedable != null:
		var distance_offset: int = 16
		var soils = get_tree().get_nodes_in_group("Soil")
		
		for soil: Soil in soils:
			var distance: int = int(soil.global_position.x - global_position.x)
			
			if distance == distance_offset or distance == -distance_offset:
				plant.crossbreed(soil.plant.get_class())

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
		if plant != null and plant.harvestable:
			world.new_day.disconnect(plant.grow)
			plant.harvest()
			plant = null
		return
	
	if item is Uranium:
		if !has_uranium:
			item.queue_free()
			set_has_uranium(true)
		else:
			item.interact(null)
	elif "plantable" in item and item.plantable == true:
		item.global_position = marker.global_position
		item.holdable = false
		plant = item
		plant.frame = 1
		world.new_day.connect(plant.grow)
		

func set_has_uranium(b: bool):
	has_uranium = b
	uranium_light.enabled = b
	
	if b:
		play("default")
	else:
		play_backwards("default")
