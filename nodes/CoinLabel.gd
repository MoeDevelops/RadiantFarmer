extends Label

@export var sprite: AnimatedSprite2D = null
@export var world: World = null

func add_coins(coins: int):
	var new_value = world.money + coins
	world.money = new_value
	text = str(new_value)
	sprite.play("default")
