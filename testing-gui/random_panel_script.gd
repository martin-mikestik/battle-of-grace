extends Panel

var aligned_position: Vector2
var offscreen_global_position_start: Vector2
var offscreen_global_position_end: Vector2

var transition_time: float = 0.5

signal panel_achieved_position
signal panel_floated_away

var reached_aligned_position: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aligned_position = position
	
	offscreen_global_position_start = Vector2(-size.x, global_position.y)
	offscreen_global_position_end = Vector2(get_viewport_rect().size.x, global_position.y)
	
	reached_aligned_position = false
	
	await get_tree().process_frame
	
	global_position = offscreen_global_position_start
	visible = true
	
	float_in()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("LaunchPromptGeneration") and reached_aligned_position:
		float_away()

func float_in():
	var tween = create_tween()
	tween.tween_property(self, "position", aligned_position, transition_time)\
			.set_trans(Tween.TRANS_CUBIC)\
			.set_ease(Tween.EASE_OUT)
	await tween.finished
	reached_aligned_position = true
	panel_achieved_position.emit()

func float_away():
	var tween = create_tween()
	tween.tween_property(self, "global_position",  offscreen_global_position_end, transition_time)\
			.set_trans(Tween.TRANS_CUBIC)\
			.set_ease(Tween.EASE_OUT)
	
	await tween.finished
	panel_floated_away.emit()
	print(position)
	queue_free()

	
