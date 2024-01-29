extends Node2D
class_name World

var money: int = 50
var rent: int = 5
var days: int = 0
var score: int = 0

@export var player: Player = null
@export var coin_sprite: AnimatedSprite2D = null
@export var coin_label: Label = null

signal new_day
signal lose

func _on_sleep_button_pressed():
	rent += days
	money -= rent
	
	if money < 0:
		lose.emit(score)
	else:
		new_day.emit()


func _on_new_day():
	days += 1
	coin_label.text = str(money)
	
func update_label():
	coin_label.text = str(money)
	coin_sprite.play("default")

func _on_crops_button_pressed():
	if player.item == null and money >= 10:
		var rn = randi_range(0, 3)
		var crop: AnimatedSprite2D = null
		if rn == 0:
			crop = preload("res://nodes/farming/rice.tscn").instantiate()
		elif rn == 1:
			crop = preload("res://nodes/farming/carrot.tscn").instantiate()
		elif rn == 2:
			crop = preload("res://nodes/farming/strawberry.tscn").instantiate()
		elif rn == 3:
			crop = preload("res://nodes/farming/pineapple.tscn").instantiate()
		else:
			print_debug("Invalid random number " + str(rn))
		
		add_child(crop)
		crop.player = player
		player.item = crop
		crop.picked_up = true
		
		money -= 10
		update_label()

func _on_uranium_button_pressed():
	if player.item == null and money >= 20:
		var uranium: Uranium = preload("res://nodes/farming/uranium.tscn").instantiate()
		add_child(uranium)
		uranium.player = player
		player.item = uranium
		uranium.picked_up = true
		
		money -= 20
		update_label()
