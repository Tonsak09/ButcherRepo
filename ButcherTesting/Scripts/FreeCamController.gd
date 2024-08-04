extends Node3D

@export var speed : float

@export var speedH = 2.0
@export var speedV = 2.0

var holdMouse : Vector2
var yaw = 0.0
var pitch = 0.0

var canControl : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	holdMouse = get_viewport().get_mouse_position()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	canControl = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MovementBody(delta)
	#MovementRot(delta)
	
	if Input.is_action_just_pressed("ToggleController"):
		canControl = !canControl
	
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()

func _input(event):
	
	if !canControl:
		return
	
	if event is InputEventMouseMotion:
		# modify accumulated mouse rotation
		yaw += event.relative.x * -speedH * get_process_delta_time()
		pitch += event.relative.y * -speedV * get_process_delta_time()
		transform.basis = Basis() # reset rotation
		rotate_object_local(Vector3(0, 1, 0), yaw) # first rotate in Y
		rotate_object_local(Vector3(1, 0, 0), pitch) # then rotate in X


func MovementBody(delta):
	
	if !canControl:
		return
	
	var moveAxis : Vector3
	
	if Input.is_action_pressed("Forward"):
		moveAxis -= transform.basis.z
	elif Input.is_action_pressed("Backward"):
		moveAxis += transform.basis.z
	
	if Input.is_action_pressed("Right"):
		moveAxis += transform.basis.x
	elif Input.is_action_pressed("Left"):
		moveAxis -= transform.basis.x
	
	moveAxis = moveAxis.normalized()
	position += moveAxis * speed * delta;
