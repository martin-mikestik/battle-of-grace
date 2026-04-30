extends CharacterBody2D

@export var speed: float = 300.0
@onready var prompt_labels: Node2D = $PromptLabels
@export var energy_bar: Control = null

var has_prompt: bool = false

const EXPLOSION = preload("uid://b5kv1hvj1080o")

# -- energy system --
var current_energy: int = 0
var maximum_energy: int = 3


@export var duration: float = 0.8


func _ready():
	GameManager.player = self
	connect_all_signals()
	configure_start_energy_bar()


func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)

func handle_key_presses(key_press: String):
	if key_press == "1":
		add_energy_slots(1)
	if key_press == "0":
		add_energy_slots(3)
	if key_press == "2":
		fill_energy_slots(1)
	if key_press == "3":
		remove_energy_slots(1)

#region Energy System

func configure_start_energy_bar():
	if energy_bar:
		if not energy_bar.is_node_ready():
			await energy_bar.ready
		energy_bar.add_energy_slots(3)
	else:
		print("Error: There is no energy bar.")

func add_energy_slots(num: int):
	for i in range(num):
		maximum_energy += 1
		energy_bar.add_energy_slots(1)

func remove_energy_slots(num: int):
	for i in range(num):
		if maximum_energy > 1:
			if current_energy == maximum_energy:
				current_energy -= 1
			maximum_energy -= 1
			energy_bar.remove_energy_slots(1)

func fill_energy_slots(num: int):
	for i in range(num):
		if current_energy < maximum_energy:
			current_energy += 1
			energy_bar.fill_energy_slots(1)

func print_energy_info():
	print("energy: " + str(current_energy) + "/" + str(maximum_energy))

#endregion


func _process(delta):
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
	#juicy_rotate(360)
	
func launch_explosion(color_modulate: Color):
	print("launched here")
	var instance = EXPLOSION.instantiate()
	instance.modulate = color_modulate
	add_child(instance)
	instance.explode()

func juicy_rotate(target_rotation_deg: float, duration: float):
	var tween = create_tween()
	var target_rad = deg_to_rad(target_rotation_deg)
	
	tween.tween_property(self, "rotation", target_rad, duration)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN_OUT)
		
	#await tween.finished
	#await get_tree().create_timer(0.4).timeout
	#launch_explosion()
	
