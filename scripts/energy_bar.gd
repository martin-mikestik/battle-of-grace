extends Control

const ENERGY_SLOT = preload("uid://bkm6mdr635hnw")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var list_energy_slots: Array[ProgressBar] = []
var num_slots: int = 0
var filled_slots: int = 0

func _ready():
	connect_all_signals()
	print(h_box_container)

func connect_all_signals():
	pass
	#InputHandler.key_press.connect(handle_key_presses)





func add_energy_slots(num: int):
	for i in range(num):
		if not h_box_container.is_node_ready():
			await h_box_container.ready
		var energy_slot_instance = ENERGY_SLOT.instantiate()
		h_box_container.add_child(energy_slot_instance)
		list_energy_slots.append(energy_slot_instance)
		num_slots += 1
		recalculate_filled_slots()

func remove_energy_slots(num: int):
	for i in range(num):
		if num_slots != 0:
			list_energy_slots[0].queue_free()
			list_energy_slots.remove_at(0)
			if filled_slots == num_slots:
				filled_slots -= 1
			num_slots -= 1
			recalculate_filled_slots()


func fill_energy_slots(num: int):
	for i in range(num):
		if filled_slots < num_slots:
			var slot_to_fill_index: int = filled_slots
			filled_slots += 1
			recalculate_filled_slots()
		

func recalculate_filled_slots():
	for i in range(0, num_slots - filled_slots):
		list_energy_slots[i].value = list_energy_slots[i].min_value
	for i in range(num_slots - filled_slots, num_slots):
		list_energy_slots[i].value = list_energy_slots[i].max_value


# Interface:
# - increase/descrease maximum number of slots by n
# - fill/deplete n slots
# - tween everything
# - decouple graphics from energy logic
