extends CharacterBody2D

@onready var ray = $BasicRay
@onready var sprite = $AnimatedSprite2D
@onready var is_on_floor = $IsOnFloor
@onready var collision = $CollisionShape2D
@onready var animation = $AnimationPlayer

var animation_speed = 3
var moving = false
var on_ledder = false

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

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	if moving: 
		return
	
	if dir == "right":
		sprite.scale.x = 1
	elif dir == "left":
		sprite.scale.x = -1
		
	
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		animation.play("run")
		await tween.finished
		animation.play("idle")
		moving = false
	else:
		var colider = ray.get_collider()
		if colider.is_in_group("moveable"):
			colider.move(dir)


