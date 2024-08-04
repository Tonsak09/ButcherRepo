extends Node3D

@export var mode : FollowType
@export var target : Node3D 
@export var followSpeed : float 
@export var fallOffMax : float
@export var falloffCurve : Curve 

var offset : Vector3
enum FollowType {LOCKED, ALL, AXIS_X, AXIS_Z}

# Called when the node enters the scene tree for the first time.
func _ready():
	offset = global_position - target.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = target.global_position + offset
	
	match mode:
		FollowType.ALL:
			pos = global_position
		FollowType.AXIS_X:
			pos.z = global_position.z
		FollowType.AXIS_Z:
			pos.x = global_position.x
		
	
	
	var dir = (pos - global_position).normalized()
	var disSqr = (pos - global_position).length_squared()
	var interp = disSqr / fallOffMax
	
	global_position += dir * followSpeed * delta * falloffCurve.sample(interp)
