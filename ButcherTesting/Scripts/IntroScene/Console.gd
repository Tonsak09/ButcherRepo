extends Node3D

@export var terminalLabel : MeshInstance3D
@export var screen : TerminalScreens

# Startup screen 
@export var startupTime : float 
@export var dotTimer : float 
@export var lines : Array[String]

# Code display 
@export var codeTime : float 
@export var codePause : float 
@export var codeActiveMax : int 
@export var codeLines : Array[String]

# Terminal input 
@export var maxNameSize : int 
@export var underscoreTime : float 

var currDot : int
var currCode : int 

var stateTimer : float 
var timer : float 

var inputName : String
var showUnderscore : bool 
var checkIfConfirm : bool 

var introScene

enum TerminalScreens { STARTUP, CODE, INTERFACE }

func _ready():
	currDot = 0
	introScene = load("res://Scenes/MainScene.tscn")

func _process(delta):
	
	match screen:
		TerminalScreens.STARTUP:
			Startup(delta)
			stateTimer += delta
			if stateTimer >= startupTime:
				stateTimer = 0.0
				screen = TerminalScreens.CODE
		TerminalScreens.CODE:
			Code(delta)
			stateTimer += delta
			if stateTimer >= codeTime:
				stateTimer = 0.0
				screen = TerminalScreens.INTERFACE
		TerminalScreens.INTERFACE:
			Interface(delta)

func _input(event):
	
	
	if screen != TerminalScreens.INTERFACE:
		return
	
	if event is InputEventKey && event.is_pressed():
		var input : String 
		input = event.as_text()
		
		match input:
			"Backspace":
				inputName = inputName.left(inputName.length() - 1)
			_:
				if input.length() == 1 and inputName.length() < maxNameSize:
					inputName += input

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

# Runs code across screen 
func Code(delta):
	
	if currCode > codeLines.size():
		return
	
	terminalLabel.mesh.text = GetCode(currCode)
	
	timer += delta
	if timer >= codePause:
		timer = 0.0
		currCode += 1

func GetCode(codeLine : int):
	var minValue = max(0, codeLine - codeActiveMax) 
	var diff = codeLine - minValue
	var codeStr = ""
	
	for i in diff:
		codeStr += codeLines[minValue + i] + "\n"
	
	return codeStr

# Indicates player can type name and handles the input 
func Interface(delta):
	
	if checkIfConfirm :
		if Input.is_action_pressed("ui_accept"):
			var instance = introScene.instantiate()
			get_tree().root.add_child(instance)
			get_node("/root/ConsoleInteract").free()
		return 
	else:
		if Input.is_action_pressed("ui_accept"):
			checkIfConfirm = true

	
	terminalLabel.mesh.text = "Name ID:\n" + inputName 
	
	if showUnderscore && inputName.length() < maxNameSize:
		terminalLabel.mesh.text += "_"
	
	timer += delta; 
	if timer >= underscoreTime:
		timer = 0.0
		showUnderscore = !showUnderscore
