extends Label

@export var sprite: AnimatedSprite2D = null

func add_coins(coins: int):
	text = str(int(text) + coins)
	sprite.play("default")
