extends RichTextLabel

@export var expected_text: String = "hello world"
@export var unfinished_color: Color = Color(0.0, 0.0, 0.0, 0.616)
@export var completed_color: Color = Color(1.0, 0.357, 0.29, 1.0)

var next_necessary_letter_index: int = 0

func _ready():
	InputHandler.key_press.connect(get_pressed_key)
	text = RichLabelHelper.add_color_tag(expected_text, unfinished_color.to_html())

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
		#print(next_necessary_letter_index)
		update_label_color()
		
	#print(key_name + ": here")

func update_label_color() -> void:
	var completed_text: String = ""
	var unfinished_text: String = ""
	var remaining_text_length: int = len(expected_text) - next_necessary_letter_index
	
	print("expected text: " + expected_text)
	completed_text = expected_text.substr(0, next_necessary_letter_index)
	var completed_text_1 = RichLabelHelper.add_color_tag(completed_text, completed_color.to_html())
	print("expected text: " + expected_text)
	unfinished_text = expected_text.substr(next_necessary_letter_index, remaining_text_length)
	var unfinished_text_1 = RichLabelHelper.add_color_tag(unfinished_text, unfinished_color.to_html())
	
	print("expected text: " + expected_text)
	print(completed_text_1)
	print(unfinished_text_1)
	
	var result = completed_text_1 + unfinished_text_1
	text = result
