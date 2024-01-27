extends CharacterBody2D
class_name Player

@export var max_speed: float = 120
@export var acceleration: float = 10

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, max_speed * direction.x, acceleration)
	velocity.y = move_toward(velocity.y, max_speed * direction.y, acceleration)
	
	if velocity.x == 0 and velocity.y == 0:
		sprite.play("Idle")
	else:
		sprite.play("Walk")	
		
		if velocity.x != 0:
			sprite.flip_h = velocity.x < 0
			

	move_and_slide()
