extends BaseEffect

@export var rotation_degrees: float = 360
@export var duration: float = 0.6

func apply_effect_on_player():
	print("Player rotated.")
	player.juicy_rotate(360, 0.6)
	
