extends MeshInstance3D

@export var terminalLabel : MeshInstance3D
@export var screen : TerminalScreens

@export var dotTimer : float 
@export var lines : Array[String]
@export var codePause : float 
@export var codeActiveMax : int 
@export var codeLines : Array[String]

var currDot : int
var currCode : int 

var timer : float 

enum TerminalScreens { STARTUP, CODE, INTERFACE }

func _ready():
	currDot = 0

func _process(delta):
	
	match screen:
		TerminalScreens.STARTUP:
			Startup(delta)
		TerminalScreens.CODE:
			Code(delta)
	
	

# Bootup stage 
func Startup(delta):
	var text : String
	
	for line in lines:
		text += line + GetDot(currDot) + "\n"
	
	terminalLabel.mesh.text = text
	
	timer += delta
	if timer >= dotTimer:
		timer = 0.0
		
		currDot += 1
		if currDot > 3:
			currDot = 0

func GetDot(count : int):
	var dotText : String
	for i in count:
		dotText += "."
	
	return dotText 

func Code(delta):
	terminalLabel.mesh.text = GetCode(currCode)
	
	timer += delta
	if timer >= codePause:
		timer = 0.0
		
		currCode += 1
		if currCode > codeLines.size():
			currCode = 0

func GetCode(codeLine : int):
	var minValue = max(0, codeLine - codeActiveMax) 
	var diff = codeLine - minValue
	var codeStr = ""
	
	for i in diff:
		codeStr += codeLines[minValue + i] + "\n"
	
	return codeStr
