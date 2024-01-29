extends Control

@export var world: World = null
@onready var score: Label = $Score
@onready var high_score: Label = $HighScore
var path = "user://score.txt"

func _ready():
	world.lose.connect(reveal)
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		high_score.text = str(file.get_32())
		file.close()
	else:
		high_score.text = "0"


func reveal(scr: int):
	z_index = 1000
	score.text = str(scr)
	
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		var file_high_score = file.get_32()
		if scr > file_high_score:
			file.store_32(scr)
	else:
		FileAccess.open(path, FileAccess.WRITE).store_32(scr)
	
	visible = true
	

func _on_exit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	get_tree().reload_current_scene()
