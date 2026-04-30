extends Node

@export var num_words_range: Vector2i = Vector2i(1, 3)

const TEXT_INPUT = preload("uid://ukdg61uwdpi2")


var possible_words: Array = []

func _ready():
	WordDataset.words_prepared.connect(configure_possible_words)

func configure_possible_words():
	possible_words = WordDataset.dict_enum_to_wordset.get(WordDataset.WORDSET.english_100)

func generate_prompt() -> RichTextLabel:
	var instance: RichTextLabel = TEXT_INPUT.instantiate()
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
	
	#print(expected_text)
	return expected_text
