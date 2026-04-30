extends CharacterBody2D

@export var speed: float = 300.0
@onready var prompt_labels: Node2D = $PromptLabels
@export var energy_bar: Control = null

var has_prompt: bool = false

const EXPLOSION = preload("uid://b5kv1hvj1080o")

# -- energy system --
var current_energy: int = 0
var maximum_energy: int = 3


@export var rotation_curve: Curve
@export var duration: float = 0.8

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
	
	juicy_rotate(360)
	
func launch_explosion():
	var instance = EXPLOSION.instantiate()
	add_child(instance)
	instance.explode()

func juicy_rotate(target_rotation_deg: float):
	var tween = create_tween()
	# Convert degrees to radians for the rotation property
	var target_rad = deg_to_rad(target_rotation_deg)
	
	
	
	tween.tween_property(self, "rotation", target_rad, 0.6)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_IN_OUT)
		
	#await tween.finished
	await get_tree().create_timer(0.4).timeout
	launch_explosion()
	
