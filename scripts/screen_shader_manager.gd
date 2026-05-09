extends Node

const SCREEN_SHADER_CANVAS_LAYER = preload("uid://da78bm2008qhl")

const MAGENTA_DEFAULT_SHADER = preload("uid://ckg74qwgch20b")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		add_canvas_layer_shader_for(3)



func add_canvas_layer_shader_for(time_sec: float):
	var canvas_layer = SCREEN_SHADER_CANVAS_LAYER.instantiate()

	# add shader as material
	print(canvas_layer.get_child(0))
	var color_rect_material: Material = canvas_layer.get_child(0).material
	color_rect_material.shader = MAGENTA_DEFAULT_SHADER
	
	add_child(canvas_layer)
	
	await get_tree().create_timer(time_sec).timeout
	
	canvas_layer.queue_free()
