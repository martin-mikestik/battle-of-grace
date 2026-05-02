extends Panel

var is_unlocked: bool = false


var new_stylebox = StyleBoxFlat.new()
var inactive_stylebox: StyleBox = null
@export var original_color: Color = Color(0, 0, 0, 0)
@export var active_color: Color = Color(0, 0, 0, 0)

@onready var label: Label = $SkillButtonForeground/Label

@export var my_text: String = ""

var necessary_energy: int = 3

# cooldown
var current_time: int = 0
var cooldown_time: float = 5
var last_time_used: float = 0 # in unix milliseconds
var cooldown_expired: bool = false

# visual stuff
var my_material: Material = null

func _ready():
	label.text = my_text
	inactive_stylebox = get_theme_stylebox("panel")
	original_color = inactive_stylebox.bg_color

func _process(_delta):
	recalculate_flags()
	handle_user_input()
	handle_visuals()

func handle_user_input():
	if Input.is_action_just_pressed("StartSkills"):
		make_active()
	if Input.is_action_just_released("StartSkills"):
		make_passive()

func recalculate_flags():
	current_time = Time.get_unix_time_from_system() * 1000
	cooldown_expired = current_time - last_time_used > cooldown_time * 1000

func handle_visuals():
	update_cooldown_shader()

func make_active():
	#add_theme_stylebox_override("panel", new_stylebox)
	print("made active")
	set_off()
	inactive_stylebox.bg_color = active_color

func make_passive():
	inactive_stylebox.bg_color = original_color
	#add_theme_stylebox_override("panel", inactive_stylebox)


func try_set_off():
	if is_unlocked and\
	cooldown_expired and\
	get_user_energy() >= necessary_energy:
		set_off()

func set_off():
	# update flags like cooldown
	# take away player's energy
	# perform the effect
	last_time_used = Time.get_unix_time_from_system() * 1000
	deplete_user_energy()
	
	print("Button " + name + " was set off.")

func get_user_energy():
	if GameManager.player:
		return GameManager.player.current_energy
	else:
		return 1000

func deplete_user_energy():
	if GameManager.player:
		GameManager.player.deplete_energy_slots(necessary_energy)
	else:
		print("no player attached")

#region Visual Aspects

func update_cooldown_shader():
	var shader_uncovered_degrees = 0
	var percentage_should_uncover = (current_time - last_time_used) / (cooldown_time * 1000)
	if percentage_should_uncover > 1:
		percentage_should_uncover = 0
	shader_uncovered_degrees = 360.0 * percentage_should_uncover
	material.set_shader_parameter("degrees_uncovered", shader_uncovered_degrees)

#endregion
