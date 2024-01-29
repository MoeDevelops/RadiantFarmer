extends CharacterBody2D
class_name Player

@export var max_speed: float = 120
@export var acceleration: float = 10

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var marker: Marker2D = $Marker2D

var item = null

signal interact

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		var local_item = item
		print_debug(local_item)
		interact.emit(local_item)

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	velocity.x = move_toward(velocity.x, max_speed * direction.x, acceleration)
	velocity.y = move_toward(velocity.y, max_speed * direction.y, acceleration)
	
	if velocity.x == 0 and velocity.y == 0:
		sprite.play("Idle")
	else:
		sprite.play("Walk")	
		
		if velocity.x != 0:
			flip(velocity.x < 0)
			
	move_and_slide()

func flip(left: bool):
	sprite.flip_h = left
	
	if left:
		var marker_pos: Vector2 = marker.position
		
		if marker_pos.x > 0:
			marker.position = Vector2(marker_pos.x * -1, marker_pos.y)
	else:
		var marker_pos: Vector2 = marker.position
		
		if marker_pos.x < 0:
			marker.position = Vector2(marker_pos.x * -1, marker_pos.y)
