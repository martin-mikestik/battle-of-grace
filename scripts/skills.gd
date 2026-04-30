extends Control

var l_active: bool = false


func _ready():
	connect_all_signals()
	process_input()
	handle_visuals_skill_button()

func connect_all_signals():
	pass

func process_input():
	if Input.is_action_just_pressed("StartSkills"):
		l_active = true
	if Input.is_action_just_released("StartSkills"):
		l_active = false

func handle_visuals_skill_button():
	
