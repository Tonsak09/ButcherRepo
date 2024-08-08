extends PathFollow3D

@export var hallLightEnergy : float 
@export var lightCurve : Curve
@export var lights : Array[SpotLight3D]


# Called when the node enters the scene tree for the first time.
func _ready():
	for light in lights:
		light.light_energy = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var index = floor(progress_ratio * lights.size())
	
	if(index < lights.size()):
		lights[index].light_energy = lerp(0.0, hallLightEnergy, lightCurve.sample((progress_ratio * lights.size()) - index)) 
	
