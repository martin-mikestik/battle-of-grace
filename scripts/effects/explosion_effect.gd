extends BaseEffect

@export var delay: float = 0.4
@export var modulate_color: Color = Color.AQUAMARINE

func apply_effect_on_player():
	print("Explosion activated.")
	#await get_tree().create_timer(delay).timeout
	
	
	player.launch_explosion(modulate_color)
