extends Node

func add_color_tag(content: String, color_hex: String) -> String:
	var result: String = ""
	result += "[color=#" + color_hex +"]"
	result += content
	result += "[/color]"
	return result
	
