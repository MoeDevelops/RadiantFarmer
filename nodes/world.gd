extends Node2D
class_name World

var money: int = 50
var rent: int = 5
var days: int = 0
var score: int = 0

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
