extends BaseEffect

@export var rotation_degrees: float = 360
@export var duration: float = 0.6

	
func set_off():
	print("Player rotated.")
	GameManager.player.juicy_rotate(360, 0.6)
