extends BaseEffect

func set_off():
	print("Player's energy increased.")
	GameManager.player.fill_energy_slots(1)
	
