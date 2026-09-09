extends Node

var player: Node = null


enum KeyboardMode { PROMPT, MOVE }
var keyboard_mode = KeyboardMode.MOVE

func toggle_keyboard_mode():
	if keyboard_mode == KeyboardMode.MOVE:
		keyboard_mode = KeyboardMode.PROMPT
	else:
		keyboard_mode = KeyboardMode.MOVE
		

func _process(_delta):
	if Input.is_action_just_pressed("ToggleKeyboardMode"):
		toggle_keyboard_mode()