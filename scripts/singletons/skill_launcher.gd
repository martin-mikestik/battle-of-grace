extends Node

@onready var energy_skill: Skill = $EnergySkill
@onready var drill_skill: Skill = $Drill_Skill

func launch_energy_skill():
	energy_skill.set_off()


func launch_drill_skill():
	drill_skill.set_off()
