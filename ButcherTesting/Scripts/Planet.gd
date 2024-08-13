extends MeshInstance3D

@export var tiltSpeed : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#transform.basis = Basis() # reset rotation
	transform.basis = transform.basis.rotated(Vector3.FORWARD, tiltSpeed * delta)
