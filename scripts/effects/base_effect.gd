extends Node
class_name BaseEffect

var player: Node = null

func _ready():	
	player = GameManager.player

func _on_effect_completion():
	if player:
		apply_effect_on_player()
	else:
		print("Error: no player attached to effect.")

func apply_effect_on_player():
	print("Base effect applied")
