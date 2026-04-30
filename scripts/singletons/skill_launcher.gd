extends Node

@onready var energy_skill: Skill = $EnergySkill
@onready var drill_skill: Skill = $Drill_Skill

enum SKILL_TYPE {
	EnergySlot,
	Drill
}

@export var dict_enum_to_skill: Dictionary[SKILL_TYPE, Node]

func launch_energy_skill():
	energy_skill.activate()


func launch_drill_skill():
	drill_skill.activate()
