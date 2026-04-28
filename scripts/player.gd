extends CharacterBody2D

@export var speed: float = 300.0
@onready var prompt_labels: Node2D = $PromptLabels


func _process(delta):
	if Input.is_action_just_pressed("LaunchPromptGeneration"):
		var instance: RichTextLabel = TextPromptGenerator.generate_prompt()
		prompt_labels.add_child(instance)

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
