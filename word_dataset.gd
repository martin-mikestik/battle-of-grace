extends Node

var english_100_filename: String = "res://assets/word_lists/english_100.json"
var english_1k_filename: String = "res://assets/word_lists/english_1k.json"
var english_5k_filename: String = "res://assets/word_lists/english_5k.json"
var english_10k_filename: String = "res://assets/word_lists/english_10k.json"
var english_25k_filename: String = "res://assets/word_lists/english_25k.json"
var english_450k_filename: String = "res://assets/word_lists/english_450k.json"
var english_misspelled_filename: String = "res://assets/word_lists/english_misspelled"
var english_shakespearean_filename: String = "res://assets/word_lists/english_shakespearean.json"

signal words_prepared

var dict_str_to_pathname: Dictionary[String, String] = {
	"english_100": english_100_filename,
	"english_1k": english_1k_filename,
	"english_5k": english_5k_filename,
	"english_10k": english_10k_filename,
	"english_25k": english_25k_filename,
	"english_450k": english_450k_filename,
	"english_misspelled": english_misspelled_filename,
	"english_shakespearean": english_shakespearean_filename,
}

var dict_str_to_wordset: Dictionary[String, Variant] = { }

func _ready():
	load_all_word_lists()
	print(dict_str_to_wordset.get("english_100"))
	words_prepared.emit()

func load_all_word_lists():
	for key in dict_str_to_pathname.keys():
		var path = dict_str_to_pathname.get(key)
		dict_str_to_wordset[key] = load_word_list(path)

func load_word_list(path: String) -> Array:
	if not FileAccess.file_exists(path):
		push_error("File not found: " + path)
		return []

	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	var error = json.parse(content)
	
	if error == OK:
		var data = json.data
		if data is Dictionary and data.has("words"):
			return data["words"]
		else:
			push_error("Unexpected JSON format.")
	else:
		push_error("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
	
	return []
