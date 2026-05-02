# skill.gd (singleton!)
class_name Skill
extends Node

func activate() -> void:
	_run_sequence()

func _run_sequence() -> void:
	for step in get_children():
		if not step is SkillStep:
			continue
		if is_instance_valid(step.action):
			step.action.set_off()
		if step.delay_after > 0.0:
			await get_tree().create_timer(step.delay_after).timeout

func _process(_delta):
	if Input.is_action_just_pressed("LaunchPromptGeneration"):
		activate()
