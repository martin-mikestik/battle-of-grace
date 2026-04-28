extends CharacterBody2D

@export var speed: float = 300.0


func _process(delta):
	if Input.is_action_just_pressed("LaunchPromptGeneration"):
		var instance: TextEdit = TextPromptGenerator.generate_prompt()
		add_child(instance)
		instance.grab_focus()

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if direction:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()
