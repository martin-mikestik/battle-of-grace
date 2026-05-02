extends Panel

@export var is_unlocked: bool = false
var is_l_pressed: bool = false

var new_stylebox = StyleBoxFlat.new()
var inactive_stylebox: StyleBox = null
@export var original_color: Color = Color(0, 0, 0, 0)
@export var active_color: Color = Color(0, 0, 0, 0)

@onready var label: Label = $SkillButtonForeground/Label

@export var my_text: String = ""
@export var necessary_button: String = "2"

@export var necessary_energy: int = 3

# cooldown
var current_time: int = 0
@export var cooldown_time: float = 20
var last_time_used: float = 0 # in unix milliseconds
var cooldown_expired: bool = false

# visual stuff
var my_material: Material = null

func _ready():
	connect_all_signals()
	current_time = Time.get_unix_time_from_system() * 1000
	last_time_used = current_time
	inactive_stylebox = get_theme_stylebox("panel")
	original_color = inactive_stylebox.bg_color
	my_text = "L" + necessary_button
	label.text = my_text
	
func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)

func _process(_delta):
	recalculate_flags()
	handle_user_input()
	handle_visuals()

func handle_user_input():
	if Input.is_action_just_pressed("StartSkills"):
		make_active()
	if Input.is_action_just_released("StartSkills"):
		make_passive()

func handle_key_presses(key_press: String):
	if key_press == necessary_button:
		try_set_off()

func recalculate_flags():
	current_time = Time.get_unix_time_from_system() * 1000
	cooldown_expired = current_time - last_time_used > cooldown_time * 1000

func handle_visuals():
	update_cooldown_shader()

func make_active():
	is_l_pressed = true
	#set_off()
	inactive_stylebox.bg_color = active_color

func make_passive():
	is_l_pressed = false
	inactive_stylebox.bg_color = original_color


func try_set_off():
	print("is unlocked? " + str(is_unlocked))
	print("cooldown expired? " + str(cooldown_expired))
	print("energy? " + str(get_user_energy()) + "/" + str(necessary_energy))
	print("l pressed? " + str(is_l_pressed))
	if is_unlocked and\
	cooldown_expired and\
	get_user_energy() >= necessary_energy and\
	is_l_pressed:
		set_off()
		#pass
		

func set_off():
	print("REALLY?")
	# update flags like cooldown
	# take away player's energy
	# perform the effect
	last_time_used = Time.get_unix_time_from_system() * 1000
	deplete_user_energy()
	
	#print("Button " + name + " was set off.")

func get_user_energy():
	if GameManager.player:
		return GameManager.player.current_energy
	else:
		print("No player attached. (get user energy)")
		return 1000

func deplete_user_energy():
	if GameManager.player:
		GameManager.player.deplete_energy_slots(necessary_energy)
	else:
		print("No player attached. (deplete)")

#region Visual Aspects

func update_cooldown_shader():
	var shader_uncovered_degrees = 0
	var percentage_should_uncover = (current_time - last_time_used) / (cooldown_time * 1000)
	if percentage_should_uncover > 1:
		percentage_should_uncover = 1
	shader_uncovered_degrees = 360.0 * percentage_should_uncover
	material.set_shader_parameter("degrees_uncovered", shader_uncovered_degrees)

#endregion
