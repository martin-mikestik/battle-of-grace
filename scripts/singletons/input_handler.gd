extends Node

signal key_press(key_char: String)

func _input(event: InputEvent) -> void:
	# Only process key presses, not releases or echoes (held down keys)
	if event is InputEventKey and event.pressed and not event.is_echo():
		
		# event.unicode returns the actual character code (0 if not a printable character)
		var char_code = event.unicode
		
		# ASCII printable range is 32 (Space) to 126 (~)
		if char_code >= 32 and char_code <= 126:
			var character = char(char_code)
			key_press.emit(character)
			
		# Optional: If you want to allow Extended ASCII (127-255), 
		# just change the upper bound to 255.
