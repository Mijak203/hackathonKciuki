extends CharacterBody2D

@onready var ray = $BasicRay
@onready var is_on_floor = $IsOnFloor
@onready var collision = $CollisionShape2D

var animation_speed = 3
var moving = false

var tile_size = 16
var speed = 100

var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

func _process(delta):
	is_on_floor.force_raycast_update()
	if !is_on_floor.is_colliding():
		move("down")

func move(dir):
	if moving: 
		return
	
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		await tween.finished
		moving = false
		#position += inputs[dir] * tile_size
		return true
	return false


