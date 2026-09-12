extends Control

var can_generate_new_panel: bool = true

@export var transition_time_panel: float = 0.5

@export var offset_right_left_min: float = 10
@export var offset_right_left_max: float = 400
@export var offset_top_bottom_min: float = 10
@export var offset_top_bottom_max: float = 300

const RANDOM_PANEL = preload("uid://cgqr8nsj4djpq")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_input()

func process_input():
	if Input.is_action_just_pressed("LaunchPromptGeneration"):
		if can_generate_new_panel:
			generate_new_panel()


func generate_new_panel():
	can_generate_new_panel = false
	var panel_instance: Panel = RANDOM_PANEL.instantiate()
	#var my_anchor_offset_top = randf_range(offset_top_bottom_min, offset_top_bottom_max)
	#var my_anchor_offset_bottom = -my_anchor_offset_top
	#var my_anchor_offset_right = randf_range(offset_right_left_min, offset_right_left_max)
	#var my_anchor_offset_left = -my_anchor_offset_right
	
	panel_instance.offset_top = randf_range(offset_top_bottom_min, offset_top_bottom_max)

	panel_instance.offset_bottom = -panel_instance.offset_top
	panel_instance.offset_left = randf_range(offset_right_left_min, offset_right_left_max)
	panel_instance.offset_right = -panel_instance.offset_left

	panel_instance.panel_achieved_position.connect(_on_panel_achieved_position)
	panel_instance.panel_floated_away.connect(_on_panel_floated_away)
	panel_instance.visible = false
	panel_instance.transition_time = transition_time_panel
	add_child(panel_instance)

func _on_panel_achieved_position():
	pass

func _on_panel_floated_away():
	can_generate_new_panel = true
	
