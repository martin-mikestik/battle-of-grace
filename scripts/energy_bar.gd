extends Control

const ENERGY_SLOT = preload("uid://bkm6mdr635hnw")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var list_energy_slots: Array[ProgressBar] = []
var num_slots: int = 0

func _ready():
	connect_all_signals()

func connect_all_signals():
	InputHandler.key_press.connect(handle_key_presses)


func handle_key_presses(key_press: String):
	if key_press == "1":
		add_energy_slots(1)
	if key_press == "0":
		add_energy_slots(3)

func add_energy_slots(num: int):
	for i in range(num):
		var energy_slot_instance = ENERGY_SLOT.instantiate()
		h_box_container.add_child(energy_slot_instance)
		list_energy_slots.insert(0, energy_slot_instance)
		num_slots += 1

func fill_energy_slots(num: int):
	pass

# Interface:
# - increase/descrease maximum number of slots by n
# - fill/deplete n slots
# - tween everything
# - decouple graphics from energy logic
