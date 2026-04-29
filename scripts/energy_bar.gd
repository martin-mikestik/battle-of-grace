extends Control

const ENERGY_SLOT = preload("uid://bkm6mdr635hnw")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var list_energy_slots: Array[ProgressBar] = []
var num_slots: int = 0
var filled_slots: int = 0

func _ready():
	connect_all_signals()

func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)


func handle_key_presses(key_press: String):
	if key_press == "1":
		add_energy_slots(1)
	if key_press == "0":
		add_energy_slots(3)
	if key_press == "2":
		fill_energy_slots()

func add_energy_slots(num: int):
	for i in range(num):
		var energy_slot_instance = ENERGY_SLOT.instantiate()
		h_box_container.add_child(energy_slot_instance)
		list_energy_slots.append(energy_slot_instance)
		num_slots += 1
		recalculate_filled_slots()

func fill_energy_slots(): # num: int
	if filled_slots < num_slots:
		#var slot_to_fill_index: int = num_slots - filled_slots - 1
		var slot_to_fill_index: int = filled_slots
		#list_energy_slots[slot_to_fill_index].value = list_energy_slots[slot_to_fill_index].max_value
		filled_slots += 1
		print("here")
		recalculate_filled_slots()
		

func recalculate_filled_slots():
	print("filled slots: " + str(filled_slots))
	print("num slots: " + str(num_slots))
	for i in range(0, num_slots - filled_slots):
		list_energy_slots[i].value = list_energy_slots[i].min_value
		print("adding zero energy to: " + list_energy_slots[i].name + " slot")
		#print("setting: " + str(i) + " to max")
	for i in range(num_slots - filled_slots, num_slots):
		list_energy_slots[i].value = list_energy_slots[i].max_value
		print("adding max energy to: " + list_energy_slots[i].name + " slot")

# Interface:
# - increase/descrease maximum number of slots by n
# - fill/deplete n slots
# - tween everything
# - decouple graphics from energy logic
