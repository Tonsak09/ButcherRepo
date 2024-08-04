extends CharacterBody3D

@export var cam : Camera3D
@export var moveSpeed : float 

var canControl : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	canControl = false 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Movement(delta)
	
	if Input.is_action_just_pressed("ToggleController"):
		canControl = !canControl


func Movement(delta):
	if !canControl:
		return
	
	var moveAxis : Vector3
	
	var zBasis = cam.transform.basis.z
	zBasis.y = 0;
	zBasis = zBasis.normalized()
	
	var xBasis = cam.transform.basis.x
	xBasis.y = 0;
	xBasis = xBasis.normalized()
	
	if Input.is_action_pressed("Forward"):
		moveAxis -= zBasis
	elif Input.is_action_pressed("Backward"):
		moveAxis += zBasis
	
	if Input.is_action_pressed("Right"):
		moveAxis += xBasis
	elif Input.is_action_pressed("Left"):
		moveAxis -= xBasis
	
	moveAxis = moveAxis.normalized()
	move_and_collide(moveAxis * moveSpeed * delta);
	#position += moveAxis * moveSpeed * delta;
