extends RigidBody

onready var camera = $PShip/Camera #or whichever node is the actual camera
var yaw =0
var ViewSensitivity = 1.0 
var pitch =0

#other unknowns
#var cameraLook = 0 
var rotationSpeed =0
onready var model = $PShip
#warning-ignore:unused_class_variable
var collider = 0 
var velocity_target 

#warning-ignore:unused_class_variable
var speed


const GRAVITY = 0
var vel = Vector3()
const ACCEL = 4.5

var dir = Vector3()


const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40
#added
const MAX_SPEED = 1000


#var MOUSE_SENSITIVITY = 0.05

#tweak till perfection
#var yaw# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	process_input(delta)
	process_movement(delta)


		#Called every frame. 'delta' is the elapsed time since the previous frame.
		#
#func _process(delta):
#	pass

func process_input(delta):
	
	dir = Vector3()
#warning-ignore:unused_variable
	var input_movement_vector = Vector2()
	if Input.is_action_pressed("move_forwards"):
		velocity_target -= transform.basis.z
	 #input_movement_vector.y += 1
	
	elif Input.is_action_pressed("move_backwards"):
		velocity_target += transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		velocity_target -= transform.basis.x
	elif Input.is_action_pressed("strafe_right"):
		velocity_target += transform.basis.x
#
	camera.rotation.z = 0
	var rotationTarget = model.rotation.linear_interpolate(camera.rotation, delta * rotationSpeed)
	model.rotation = rotationTarget
#	collider.rotation = rotationTarget

func process_movement(delta):
    dir.y = 0
    dir = dir.normalized()

    vel.y += delta * GRAVITY

    var hvel = vel
    hvel.y = 0

    var target = dir
    target *= MAX_SPEED

    var accel
    if dir.dot(hvel) > 0:
        accel = ACCEL
    else:
        accel = DEACCEL

    hvel = hvel.linear_interpolate(target, accel * delta)
    vel.x = hvel.x
    vel.z = hvel.z
    #vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw = yaw - event.relative.x * ViewSensitivity
		pitch = pitch - event.relative.y * ViewSensitivity
		camera.rotation = Vector3(deg2rad(pitch), deg2rad(yaw), 0)