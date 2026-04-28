extends TextEdit

@export var expected_text: String = "hello world"

func _process(delta):
	check_text()
	
	
func check_text():
	if text == expected_text:
		queue_free()
