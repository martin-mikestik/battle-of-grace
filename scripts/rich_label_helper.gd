extends Node

func add_color_tag(content: String, color_hex: String) -> String:
	var result: String = ""
	result += "[color=#" + color_hex +"]"
	result += content
	result += "[/color]"
	return result
	
func add_shake(content: String, speed: float, level: int) -> String:
	var result: String = ""
	result += "[shake rate=" + str(speed) + "level=" + str(level) + "]"
	result += content
	result += "[/shake]"
	return result
