extends Control

@export var buttons : Array[Button]
@export var uiElements : Array[Control]
@export var animSpeed : float 

var animNow : bool 
var animTimer : float 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animNow:
		for element in uiElements:
			element.position.x -= delta;
		
		animTimer += delta

func SortButtons():
	for button in buttons:
		if button.mouseIsWithin:
			self.move_child(button, get_child_count() - 1)
		else:
			pass
			self.move_child(button, 2)

func StartAnim():
	pass 
