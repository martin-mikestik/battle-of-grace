@tool

extends SubViewportContainer

@export var other_subviewport: SubViewport = null
@onready var my_sub_viewport: SubViewport = $SubViewport

func _process(delta):
	if my_sub_viewport.world_2d != other_subviewport.world_2d:
		if other_subviewport:
			if not other_subviewport.is_node_ready():
				await other_subviewport.ready
			print("setting")
			my_sub_viewport.world_2d = other_subviewport.world_2d
