class_name Level
extends Node

const Scene = {
	'Dungeon1': "res://scene/Dungeon/Dungeon.tscn",
	'MainWorld' : "res://scene/game map/game_world.tscn"
}

func switchLevel(target: String):
	get_tree().change_scene_to_file(Scene[target])
