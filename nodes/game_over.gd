extends Control

@export var world: World = null
@onready var score: Label = $Score
@onready var high_score: Label = $HighScore
var path = "res://score.txt"

func _ready():
	world.lose.connect(reveal)
	high_score.text = str(FileAccess.open(path, FileAccess.READ).get_32())

func reveal(scr: int):
	z_index = 1000
	score.text = str(scr)
	
	var file_high_score = FileAccess.open(path, FileAccess.READ).get_32()
	
	if scr > file_high_score:
		FileAccess.open(path, FileAccess.WRITE).store_32(scr)
	
	visible = true
	

func _on_exit_pressed():
	get_tree().quit()
