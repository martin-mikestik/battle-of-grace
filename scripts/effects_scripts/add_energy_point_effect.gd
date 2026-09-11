extends BaseEffect

func set_off():
	print("Energy point added to player.")
	GameManager.player.try_add_energy_points(1)
	
