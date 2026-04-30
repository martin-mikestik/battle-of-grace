extends BaseEffect

func apply_effect_on_player():
	print("Player's energy increased.")
	player.fill_energy_slots(1)
	
