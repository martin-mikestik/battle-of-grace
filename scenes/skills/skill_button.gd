extends Panel

var is_active: bool = false


var new_stylebox = StyleBoxFlat.new()
var inactive_stylebox: StyleBox = null
@export var original_color: Color = Color(0, 0, 0, 0)
@export var active_color: Color = Color(0, 0, 0, 0)

@onready var label: Label = $SkillButtonForeground/Label

@export var my_text: String = ""

func _ready():
	label.text = my_text
	inactive_stylebox = get_theme_stylebox("panel")
	original_color = inactive_stylebox.bg_color

func _process(_delta):

	if Input.is_action_just_pressed("StartSkills"):
		make_active()
	if Input.is_action_just_released("StartSkills"):
		make_passive()



func make_active():
	#add_theme_stylebox_override("panel", new_stylebox)
	inactive_stylebox.bg_color = active_color

func make_passive():
	inactive_stylebox.bg_color = original_color
	#add_theme_stylebox_override("panel", inactive_stylebox)

func set_off():
	print("Button " + name + " was set off.")
