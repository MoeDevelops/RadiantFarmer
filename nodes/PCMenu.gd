extends Node
class_name PCMenu

@onready var crops_button: Button = $CropsButton
@onready var uranium_button: Button = $UraniumButton
@onready var sleep_button: Button = $SleepButton
@onready var buttons: Array = [crops_button, uranium_button, sleep_button]

func _on_pc_area_body_entered(body):
	if body is Player:
		for button: Button in buttons:
			button.visible = true


func _on_pc_area_body_exited(body):
	if body is Player:
		for button: Button in buttons:
			button.visible = false
