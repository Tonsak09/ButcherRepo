extends Area3D

var nodesInArea : Array[Node3D]

# Adds an interactble to selection 
func BodyEntered(body : Node3D):
	nodesInArea.push_back(body)

# Removes an interactable selection 
func BodyLeave(body : Node3D):
	var index = nodesInArea.find(body)
	
	if index >= 0:
		nodesInArea.remove_at(index)

func _process(delta):
	if Input.is_mouse_button_pressed(1):
		for interactable in nodesInArea:
			interactable.AddPower(delta)
	elif Input.is_mouse_button_pressed(2):
		for interactable in nodesInArea:
			interactable.RemovePower(delta)
