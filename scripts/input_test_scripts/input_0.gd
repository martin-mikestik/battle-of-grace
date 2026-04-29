extends Node

func _input(event: InputEvent):
	print(event)
	if event is InputEventKey and event.pressed and char(event.unicode) == "s":
		print(name + ": " + str(event))
		get_viewport().set_input_as_handled()
