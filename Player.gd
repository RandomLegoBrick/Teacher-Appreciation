extends KinematicBody
 
const MOVE_SPEED = 5
const JUMP_FORCE = 4
const GRAVITY = 0.3
const MAX_FALL_SPEED = 30
 
const H_LOOK_SENS = 0.5
const V_LOOK_SENS = 0.5
 
onready var cam = $Camera
 
var y_velo = 0
 
func _ready():
	#anim.get_animation("walk").set_loop(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
 
func _input(event):
	if event is InputEventMouseMotion:
		cam.rotation_degrees.x -= event.relative.y * V_LOOK_SENS
		cam.rotation_degrees.x = clamp(cam.rotation_degrees.x, -90, 90)
		rotation_degrees.y -= event.relative.x * H_LOOK_SENS
	elif Input.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
 
func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("forward"):
		move_vec.z -= 1
	if Input.is_action_pressed("backward"):
		move_vec.z += 1
	if Input.is_action_pressed("right"):
		move_vec.x += 1
	if Input.is_action_pressed("left"):
		move_vec.x -= 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
 
	var grounded = is_on_floor()
	y_velo -= GRAVITY
	var just_jumped = false
	if grounded and Input.is_action_just_pressed("jump"):
		just_jumped = true
		y_velo = JUMP_FORCE
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
 
