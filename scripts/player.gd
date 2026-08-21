extends CharacterBody2D

@export var speed: float = 300.0
@onready var prompt_labels: Node2D = $PromptLabels
@export var energy_bar: EnergyBar = null

var has_prompt: bool = false

const EXPLOSION = preload("uid://b5kv1hvj1080o")

# -- energy system --
var start_energy_points: int = 0
var start_energy_slots: int = 3

var current_energy_points: int = 0
var current_energy_slots: int = 0

var energy_slots_cap: int = 7

@export var duration: float = 0.8


func _ready():
	GameManager.player = self
	connect_all_signals()
	configure_energy_at_game_start()


func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)

func handle_key_presses(key_press: String):
	if key_press == "1":
		add_energy_slots(1)
	if key_press == "2":
		remove_energy_slots(1)
	if key_press == "9":
		try_add_energy_points(1)
	if key_press == "0":
		try_remove_energy_points(1)

#region Energy System


# Initialize all relevant fields, and make sure that underlying truth and GUI match.
func configure_energy_at_game_start():
	current_energy_points = start_energy_points
	current_energy_slots = start_energy_slots
	
	configure_start_energy_bar()

func configure_start_energy_bar():
	if energy_bar:
		if not energy_bar.is_node_ready():
			await energy_bar.ready
		print("update visual")
		energy_bar.update_energy_visual(EnergyBar.VisualData.new(current_energy_points, current_energy_slots, energy_slots_cap) )
		
		print("adding base energy slots.")
	else:
		print("Error: There is no energy bar.")


func add_energy_slots(num: int):
	var slots_to_add: int = num
	if num > energy_slots_cap - current_energy_slots:
		slots_to_add = energy_slots_cap - current_energy_slots

	current_energy_slots += slots_to_add
	energy_bar.update_energy_visual(EnergyBar.VisualData.new(current_energy_points, current_energy_slots, energy_slots_cap) )


func remove_energy_slots(num: int):
	var slots_to_remove: int = num
	if num > current_energy_slots:
		slots_to_remove = current_energy_slots
	var energy_points_to_remove: int = 0
	if slots_to_remove > current_energy_slots - current_energy_points:
		energy_points_to_remove = slots_to_remove - (current_energy_slots - current_energy_points) # verify

	current_energy_points -= energy_points_to_remove
	current_energy_slots -= slots_to_remove

	energy_bar.update_energy_visual(EnergyBar.VisualData.new(current_energy_points, current_energy_slots, energy_slots_cap) )


func try_add_energy_points(num: int) -> bool:
	if true: # later, check for fields that will block this, like enemy spells
		var points_to_add: int = num
		if num > current_energy_slots - current_energy_points:
			points_to_add = current_energy_slots - current_energy_points
		add_energy_points(points_to_add)
		return true

	return false

func add_energy_points(num: int):
	current_energy_points += num
	energy_bar.update_energy_visual(EnergyBar.VisualData.new(current_energy_points, current_energy_slots, energy_slots_cap) )

func try_remove_energy_points(num: int) -> bool:
	if true: # later, check for fields that will block this, like enemy spells
		var points_to_remove: int = num
		if num > current_energy_points:
			points_to_remove = current_energy_points
		remove_energy_points(points_to_remove)
		return true

	return false

func remove_energy_points(num: int):
	current_energy_points -= num
	energy_bar.update_energy_visual(EnergyBar.VisualData.new(current_energy_points, current_energy_slots, energy_slots_cap) )


func print_energy_info():
	print("energy: " + str(current_energy_points) + "/" + str(current_energy_slots))

#endregion


func _process(_delta):
	handle_input()

func handle_input():
	if Input.is_action_just_pressed("LaunchPromptGeneration") and not has_prompt:
		has_prompt = true
		var prompt_instance: RichTextLabel = TextPromptGenerator.generate_prompt()
		prompt_labels.add_child(prompt_instance)
		prompt_instance.prompt_finished.connect(_on_prompt_finished)




func _physics_process(_delta: float) -> void:
	
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()

func _on_prompt_finished():
	has_prompt = false
	juicy_rotate(360, 0.2)
	
func launch_explosion(color_modulate: Color):
	var instance = EXPLOSION.instantiate()
	instance.modulate = color_modulate
	add_child(instance)
	instance.explode()

func juicy_rotate(target_rotation_deg: float, duration_rotation: float):
	var tween = create_tween()
	var target_rad = deg_to_rad(target_rotation_deg)
	
	tween.tween_property(self, "rotation", target_rad, duration_rotation)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN_OUT)
		
	#await tween.finished
	#await get_tree().create_timer(0.4).timeout
	#launch_explosion()
	
