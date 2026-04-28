extends Node

@export var num_words_range: Vector2i = Vector2i(1, 3)

const TEXT_INPUT = preload("uid://ukdg61uwdpi2")


var possible_words: Array[String] = ["hello", "word", "enemy", "delta", "elegy"]


func generate_prompt() -> TextEdit:
	var instance: TextEdit = TEXT_INPUT.instantiate()
	instance.expected_text = generate_string()
	instance.placeholder_text = instance.expected_text
	return instance

func generate_string() -> String:
	var num_words: int = randi_range(num_words_range.x, num_words_range.y)
	var expected_text: String = ""
	
	for i in range(num_words):
		var i_selected_word: int = randi_range(num_words_range.x, num_words_range.y)
		expected_text += possible_words[i_selected_word]
		expected_text += " "

	var expected_text_length: int = len(expected_text)
	expected_text = expected_text.erase(expected_text_length - 1)
	
	print(expected_text)
	return expected_text
