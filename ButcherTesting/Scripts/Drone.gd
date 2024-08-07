extends Node3D

@export var velTarget : Node3D

@export var speedThreshold : float 
@export var tiltAmount : float 
@export var tiltRate : float 
@export var bobIdle   : float 
@export var bobAcitve : float 

var vel : Vector3
var holdPos : Vector3 # Global position previous process 

var timer : float 

# Bobbing 
var startLocalY : float 

var tiltLerp : float 

var currAngle : float 


# Called when the node enters the scene tree for the first time.
func _ready():
	holdPos = velTarget.global_position
	startLocalY = position.y
	
	tiltLerp = 0.0 
	currAngle = 0.0 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currVel = (velTarget.global_position - holdPos) / delta
	holdPos = velTarget.global_position
	var speed = currVel.length()
	
	if speed > 0.1:
		vel = currVel
	
	timer += delta 
	TurningAndBobbing(delta, speed)

# Orients the drone towards a desired direction 
func TurningAndBobbing(delta, speed):
	var sLerp = speed / speedThreshold
	tiltLerp = clamp(tiltLerp + lerp(-tiltRate, tiltRate, sLerp) * delta, 0, 1) 
	
	# Tilt foward movement 
	transform.basis = Basis() # reset rotation
	transform.basis = transform.basis.rotated(Vector3.FORWARD, lerp(0.0, tiltAmount, tiltLerp))
	
	
	var projFor = Vector2(transform.basis.x.x, transform.basis.x.z).normalized()
	var projVel = Vector2(vel.x, vel.z).normalized()
	var targetAngle = -projFor.angle_to(projVel)
	
	currAngle = lerp(currAngle, targetAngle, 0.1) #angle_difference(currAngle, targetAngle)
	transform.basis = transform.basis.rotated(Vector3.UP, currAngle)
	
	# Bobbing 
	position.y = startLocalY + sin(timer) * lerp(bobIdle, bobAcitve, sLerp)
