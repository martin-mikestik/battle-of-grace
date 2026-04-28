extends Label

@export var expected_text: String = "hello world"

var next_necessary_letter_index: int = 0

func _ready():
	InputHandler.key_press.connect(get_pressed_key)

func _process(delta):
	check_text()
	
	
func check_text():
	if next_necessary_letter_index == len(expected_text):
		queue_free()

func get_needed_letter() -> String:
	return expected_text[next_necessary_letter_index]

func get_pressed_key(key_name: String):
	if key_name == get_needed_letter():
		next_necessary_letter_index += 1
		print(next_necessary_letter_index)
	#print(key_name + ": here")
