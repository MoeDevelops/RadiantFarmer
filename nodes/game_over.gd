extends Control

@export var world: World = null
@onready var score: Label = $Score

func _ready():
	world.lose.connect(reveal)

func reveal(scr: int):
	z_index = 1000
	score.text = str(scr)
	visible = true
	

func _on_exit_pressed():
	get_tree().quit()
