extends BaseEffect

func apply_effect_on_player():
	print("Energy slot added to player.")
	player.add_energy_slots(1)
	
