extends Node3D

@export var lightPath : PathFollow3D
@export var runAwayTime : float 
@export var targetOffset : Vector3

var startAnim : bool
var timer : float 

var startPos : Vector3

# Called when the node enters the scene tree for the first time.
func _ready():
	startAnim = false 
	startPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if startAnim:
		
		if timer >= runAwayTime:
			queue_free()
		
		position = lerp(startPos, startPos + targetOffset, timer / runAwayTime)
		timer += delta
	else: # Check if time to start anim 
		if lightPath.progress_ratio >= 1.0:
			startAnim = true
			print_debug("Starting")
	
