extends BaseEffect

@export var delay: float = 0.4
@export var modulate_color: Color = Color.AQUAMARINE

func set_off():
	print("Explosion activated.")
	GameManager.player.launch_explosion(modulate_color)
