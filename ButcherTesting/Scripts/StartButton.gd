extends Button

var mouseIsWithin : bool

func SetMouseIn():
	mouseIsWithin = true
	get_parent().SortButtons()

func SetMouseOut():
	mouseIsWithin = false
	get_parent().SortButtons()
