extends Control
class_name EnergyBar

const ENERGY_SLOT = preload("uid://bkm6mdr635hnw")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var list_energy_slots: Array[ProgressBar] = []

var current_energy_points_visual: int = 0
var current_energy_slots_visual: int = 0

func _ready():
	connect_all_signals()
	print(h_box_container)

func connect_all_signals():
	pass
	#InputHandler.key_press.connect(handle_key_presses)


# This should be the only method accessible from outside.
func set_energy_state_visual(new_energy_slots_visual: int, new_energy_points_visual: int, old_energy_slots_visual: int, old_energy_points_visual):
	var difference_slots = new_energy_slots_visual - old_energy_slots_visual
	
	if difference_slots >= 0:
		add_energy_slots_visual(difference_slots)
	else:
		remove_energy_slots_visual(-difference_slots)
		
	var difference_points = new_energy_points_visual - old_energy_points_visual
	if difference_points >= 0:
		add_energy_points_visual(difference_points)
	else:
		remove_energy_points_visual(-difference_points)





func add_energy_slots_visual(num: int):
	for i in range(num):
		if not h_box_container.is_node_ready():
			await h_box_container.ready
		var energy_slot_instance = ENERGY_SLOT.instantiate()
		h_box_container.add_child(energy_slot_instance)
		list_energy_slots.append(energy_slot_instance)
		current_energy_slots_visual += 1
		recalculate_filled_slots_visual()

func remove_energy_slots_visual(num: int):
	for i in range(num):
		if current_energy_slots_visual != 0:
			list_energy_slots[0].queue_free()
			list_energy_slots.remove_at(0)
			if current_energy_points_visual == current_energy_slots_visual:
				current_energy_points_visual -= 1
			current_energy_slots_visual -= 1
			recalculate_filled_slots_visual()


func add_energy_points_visual(num: int):
	for i in range(num):
		if current_energy_points_visual < current_energy_slots_visual:
			current_energy_points_visual += 1
			recalculate_filled_slots_visual()


func remove_energy_points_visual(num: int):
	for i in range(num):
		if current_energy_points_visual > 0:
			current_energy_points_visual -= 1
			recalculate_filled_slots_visual()
		


func recalculate_filled_slots_visual():
	for i in range(0, current_energy_slots_visual - current_energy_points_visual):
		list_energy_slots[i].value = list_energy_slots[i].min_value
	for i in range(current_energy_slots_visual - current_energy_points_visual, current_energy_slots_visual):
		list_energy_slots[i].value = list_energy_slots[i].max_value


# Interface:
# Outsiders can call only this function:
# set_energy_state_visual
