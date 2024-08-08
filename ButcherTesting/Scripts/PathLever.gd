extends Node3D

@export var pathFollower : PathFollow3D
@export var speed : float 

func AddPower(delta):
	pathFollower.progress_ratio += speed * delta 

func RemovePower(delta):
	pathFollower.progress_ratio -= speed * delta 
