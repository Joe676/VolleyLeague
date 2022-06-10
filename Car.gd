extends KinematicBody

var velocity = Vector3(0, 0, 0)
export var MAX_SPEED = 40
export var MAX_ROTATION_SPEED = 4
export var SLOW_DOWN_RATE = 0.3



func _ready():
	pass

func _physics_process(delta):
	var x_pressed = false
	var z_pressed = false
	#MOVEMENT INPUT
	if Input.is_action_pressed("ui_right"):
		velocity.x += MAX_SPEED
		x_pressed = !x_pressed
	if Input.is_action_pressed("ui_left"):
		velocity.x -= MAX_SPEED
		x_pressed = !x_pressed
	if Input.is_action_pressed("ui_up"):
		velocity.z -= MAX_SPEED
		z_pressed = !z_pressed
	if Input.is_action_pressed("ui_down"):
		velocity.z += MAX_SPEED
		z_pressed = ! z_pressed
	
	#FRICTION SLOWDOWN
	if not x_pressed:
		velocity.x = lerp(velocity.x, 0, SLOW_DOWN_RATE)
	
	if not z_pressed:
		velocity.z = lerp(velocity.z, 0, SLOW_DOWN_RATE)
	
	#CLAMPING THE VALUES
	if velocity.length_squared() > pow(MAX_SPEED, 2):
		velocity = velocity.normalized()*MAX_SPEED
	elif velocity.length() < 0.01:
		velocity = Vector3(0, 0, 0)
	#MOVEMENT
	velocity = move_and_slide(velocity)
	
	#ROTATING MESH BASED ON ACTUAL MOVEMENT
	#var rotation_speed_z = MAX_ROTATION_SPEED * (velocity.x / MAX_SPEED)
	#var rotation_speed_x = MAX_ROTATION_SPEED * (velocity.z / MAX_SPEED)
	#if velocity.x != 0:
	#	$MeshInstance.rotate_z(deg2rad(-rotation_speed_z))
	#if velocity.z != 0:
	#	$MeshInstance.rotate_x(deg2rad(rotation_speed_x))
		
