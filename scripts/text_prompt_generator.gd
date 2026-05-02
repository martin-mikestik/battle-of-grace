extends Node

@export var num_words_range: Vector2i = Vector2i(3, 3)

const PROMPT_LABEL = preload("uid://ukdg61uwdpi2")
#const VIEWPORT_PROMPT = preload("uid://2ujoiip4ncu4")



var possible_words: Array = []

func _ready():
	WordDataset.words_prepared.connect(configure_possible_words)

func configure_possible_words():
	possible_words = WordDataset.dict_enum_to_wordset.get(WordDataset.WORDSET.english_shakespearean)

func generate_prompt() -> RichTextLabel:
	var instance: RichTextLabel = PROMPT_LABEL.instantiate()
	#var instance: RichTextLabel = VIEWPORT_PROMPT.instantiate()
	instance.expected_text = generate_string()
	instance.text = instance.expected_text
	return instance

func generate_string() -> String:
	var num_words: int = randi_range(num_words_range.x, num_words_range.y)
	var expected_text: String = ""
	
	for i in range(num_words):
		var i_selected_word: int = randi_range(0, len(possible_words) - 1)
		expected_text += possible_words[i_selected_word]
		expected_text += " "

	var expected_text_length: int = len(expected_text)
	expected_text = expected_text.erase(expected_text_length - 1)

	return expected_text
