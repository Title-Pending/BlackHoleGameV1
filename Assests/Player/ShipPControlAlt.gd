extends RigidBody

var speed = 100
var yaw =0
var ViewSensitivity = 1.0 
var pitch =0

func _physics_process(delta):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_pressed("move_forwards"):
		translation += speed * (Vector3.FORWARD.rotated(Vector3(0, 1, 0), rotation.y)) * delta
	if Input.is_action_pressed("move_backwards"):
		translation += speed * (Vector3.BACK.rotated(Vector3(0, 1, 0), rotation.y)) * delta
	if Input.is_action_pressed("strafe_left"):
		translation += speed * (Vector3.LEFT.rotated(Vector3(0, 1, 0), rotation.y)) * delta
	if Input.is_action_pressed("strafe_right"):
		translation += speed * (Vector3.RIGHT.rotated(Vector3(0, 1, 0), rotation.y)) * delta
#CouldMoveAssesses 

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		yaw = yaw - event.relative.x * ViewSensitivity
		pitch = pitch - event.relative.y * ViewSensitivity
		$PShip/Camera.rotation = Vector3(deg2rad(pitch), deg2rad(yaw), 0)