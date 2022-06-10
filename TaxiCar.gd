extends KinematicBody

const UP = Vector3(0, 1, 0)

var velocity = Vector3(0, 0, 0)
var acceleration = Vector3(0, 0, 0)


export var MAX_SPEED = 40
export var MAX_FORCE = 20

export var JUMP_FORCE = 200

export var fall_acceleration = 75

export var player_number = 1

export var move_left_action = "move_left"
export var move_right_action = "move_right"
export var move_up_action = "move_up"
export var move_down_action = "move_down"

export var jump_action = "jump"


func _physics_process(delta):
	var desiredVelocity = Vector3(0, 0, 0)
	var x_pressed = false
	var z_pressed = false
	var tmp = Input.get_vector(move_left_action, move_right_action, move_up_action, move_down_action)
	desiredVelocity = Vector3(tmp.x, 0, tmp.y)
	#MOVEMENT INPUT
	#if Input.is_action_pressed("ui_right"):
	#	desiredVelocity.x += 1
	#if Input.is_action_pressed("ui_left"):
	#	desiredVelocity.x -= 1
	#if Input.is_action_pressed("ui_up"):
	#	desiredVelocity.z -= 1
	#if Input.is_action_pressed("ui_down"):
	#	desiredVelocity.z += 1
		
	if Input.is_action_pressed(jump_action) and is_on_floor():
		velocity.y += JUMP_FORCE
		
	
	
	desiredVelocity = desiredVelocity.normalized() * MAX_SPEED
	
	var steer = desiredVelocity - velocity
	if steer.length_squared() > MAX_FORCE * MAX_FORCE:
		steer = steer.normalized() * MAX_FORCE;
	apply_force(steer)
	apply_force(Vector3(0, -fall_acceleration, 0))
	velocity += acceleration*delta
	acceleration *= 0
	
	velocity = move_and_slide(velocity, UP)
	if velocity.length() > 0.01:
		rotate_car()
	

func rotate_car():
	var flat_vel = Vector3(velocity.x, 0, velocity.z)
	var rot = Vector3(-1, 0, 0).angle_to(flat_vel)
	if player_number == 2:
		rot *= -1
	$tmpParent.rotation.y = rot * sign(flat_vel.z)

func apply_force(force):
	acceleration += force

func _ready():
	pass
