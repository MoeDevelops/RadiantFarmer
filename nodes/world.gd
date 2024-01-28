extends Node2D
class_name World

var money: int = 50

signal new_day


func _on_sleep_button_pressed():
	new_day.emit()
