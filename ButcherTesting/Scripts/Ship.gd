extends Node3D

@export var shakeMag : float 
@export var rotMag : float 
var timer : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.z = sin(timer) * shakeMag
	timer += delta
	
	transform.basis = transform.basis.rotated(Vector3.FORWARD, sin(timer) * rotMag * delta)
