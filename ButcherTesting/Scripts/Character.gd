extends CharacterBody3D

@export var cam : Node3D
@export var moveSpeed : float 

var canControl : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	canControl = true 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Movement(delta)
	
	if Input.is_action_just_pressed("ToggleController"):
		canControl = !canControl


func Movement(delta):
	if !canControl:
		return
	
	var moveAxis : Vector3
	var isMoving = false 
	
	var zBasis = cam.transform.basis.z
	zBasis.y = 0;
	zBasis = zBasis.normalized()
	
	var xBasis = cam.transform.basis.x
	xBasis.y = 0;
	xBasis = xBasis.normalized()
	
	if Input.is_action_pressed("Forward"):
		moveAxis -= zBasis
		isMoving = true
	elif Input.is_action_pressed("Backward"):
		moveAxis += zBasis
		isMoving = true
	
	if Input.is_action_pressed("Right"):
		moveAxis += xBasis
		isMoving = true
	elif Input.is_action_pressed("Left"):
		moveAxis -= xBasis
		isMoving = true
	
	if isMoving:
		moveAxis = moveAxis.normalized()
		move_and_collide(moveAxis * moveSpeed * delta);
	else:
		velocity = Vector3(0,0,0)
	#position += moveAxis * moveSpeed * delta;
