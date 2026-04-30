extends BaseEffect

func set_off():
	print("Energy slot added to player.")
	GameManager.player.add_energy_slots(1)
	
