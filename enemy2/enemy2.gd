extends KinematicBody2D

class_name Enemy


const GRAVITY_VEC = Vector2(0, 900)
const FLOOR_NORMAL = Vector2(0, -1)

const STATE_WALKING = 0
const STATE_KILLED = 1
const WALK_SPEED = 60 

var linear_velocity = Vector2()
var direction = -1
var anim = ""

# state machine
var state = STATE_WALKING

onready var DetectWallLeft = $DetectWallLeft
onready var DetectWallRight = $DetectWallRight
onready var sprite = $Sprite

func _physics_process(delta):
	var new_anim = "idle"

	if state == STATE_WALKING:
		linear_velocity = Vector2.ZERO
		linear_velocity.x = direction * WALK_SPEED
		linear_velocity = move_and_slide(linear_velocity, FLOOR_NORMAL)

		if DetectWallLeft.is_colliding():
			direction = 1.0

		if DetectWallRight.is_colliding():
			direction = -1.0

		sprite.scale = Vector2(direction, 1.0)
		new_anim = "walk"

	if anim != new_anim:
		anim = new_anim
		($Anim as AnimationPlayer).play(anim)

