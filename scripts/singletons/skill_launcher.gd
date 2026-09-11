extends Node

# TODO: make it path-independent so that you don't have to change this on name changes
@onready var energy_skill: Skill = $AddEnergySkill
@onready var drill_skill: Skill = $DrillSkill
@onready var add_energy_point_skill: Skill = $AddEnergyPointSkill


enum SKILL_TYPE {
	EnergySlot,
	Drill
}

@export var dict_enum_to_skill: Dictionary[SKILL_TYPE, Node]

func launch_energy_skill():
	energy_skill.activate()


func launch_drill_skill():
	drill_skill.activate()
	
func launch_add_energy_point_skill():
	add_energy_point_skill.activate()
