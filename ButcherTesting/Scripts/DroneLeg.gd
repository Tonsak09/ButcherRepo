extends Node3D

@export var target : Node3D
@export var droneBody : Node3D

@export var thresholdSpeed : float
@export var idleSpeed : float 
@export var idleMag : float 
@export var activeSpeed : float 
@export var activeMag : float 




var startPos : Vector3
var dirToTarget : Vector3

var timer : float 

func _ready():
	startPos = position
	dirToTarget = (target.global_position - global_position).normalized()

func _process(delta):
	# Update Physics info  
	
	var speed = droneBody.vel.length()
	
	
	var magLerp = clamp(speed / thresholdSpeed, 0, 1)
	timer += delta * lerp(idleSpeed, activeSpeed, magLerp)
	
	position = startPos + dirToTarget * sin(timer) * lerp(idleMag, activeMag, magLerp) * delta
	
	# Interpolate leg position based on speed 
	#position = lerp(GetIdlePos(), GetActivePos(), clamp(speed / thresholdSpeed, 0, 1) )
