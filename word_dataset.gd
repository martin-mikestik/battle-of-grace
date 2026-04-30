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

enum WORDSET {
	english_100,
	english_1k,
	english_5k,
	english_10k,
	english_25k,
	english_450k,
	english_misspelled,
	english_shakespearean
}

var dict_enum_to_pathname: Dictionary[WORDSET, String] = {
	WORDSET.english_100: english_100_filename,
	WORDSET.english_1k: english_1k_filename,
	WORDSET.english_5k: english_5k_filename,
	WORDSET.english_10k: english_10k_filename,
	WORDSET.english_25k: english_25k_filename,
	WORDSET.english_450k: english_450k_filename,
	WORDSET.english_misspelled: english_misspelled_filename,
	WORDSET.english_shakespearean: english_shakespearean_filename,
}

var dict_enum_to_wordset: Dictionary[WORDSET, Variant] = { }

# 1311 when parsing all words
# 1013, 904 when parsing no words
# parsing English datasets and loading them from JSON takes cca 400 ms
func _ready():
	var ms1 = Time.get_ticks_msec()
	load_all_word_lists()
	#print(dict_enum_to_wordset.get(WORDSET.english_100))
	var ms2 = Time.get_ticks_msec()
	print(ms2 - ms1)
	words_prepared.emit()

func load_all_word_lists():
	for key in dict_enum_to_pathname.keys():
		var path = dict_enum_to_pathname.get(key)
		dict_enum_to_wordset[key] = load_word_list(path)

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
