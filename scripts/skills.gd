extends Control

var l_active: bool = false

@onready var skill_button: Panel = $HBoxContainer/SkillButton
@onready var skill_button_2: Panel = $HBoxContainer/SkillButton2
@onready var skill_button_3: Panel = $HBoxContainer/SkillButton3


var num_to_key: Dictionary[int, Panel] = {}

func _ready():
	process_input()
	connect_all_signals()
	num_to_key = {
	1: skill_button,
	2: skill_button_2,
	3: skill_button_3
}

func _process(_delta):
	process_input()

func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)

func handle_key_presses(key_press: String):
	if l_active:
		if key_press.is_valid_int():
			var key_i: int = int(key_press)
			if key_i in num_to_key.keys():
				num_to_key.get(int(key_press)).set_off()

func process_input():
	if Input.is_action_just_pressed("StartSkills"):
		l_active = true
	if Input.is_action_just_released("StartSkills"):
		l_active = false
