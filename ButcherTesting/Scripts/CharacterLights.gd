extends Node3D

@export var light : SpotLight3D
@export var minLight : float
@export var maxLight : float 
@export var lightAdjustSpeed : float 

var timer : float 

func _ready():
	timer = 0.0

func _process(delta):
	timer += lightAdjustSpeed * delta
	
	light.light_energy = lerp(minLight, maxLight, remap(sin(timer), -1.0, 1.0, 0.0, 1.0) )
