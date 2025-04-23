extends Control
@onready var proto_controller: CharacterBody3D = %ProtoController

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/character_selection.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/settings_menu.tscn")


func load_game():
	var saved_game = load("user://savegame.tres") as SavedGame
	print(saved_game.player_position)
	print(saved_game.character)
	level_manager.saved_location = saved_game.player_position
	level_manager.character_selected = saved_game.character




func _on_load_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/loading_scene.tscn")
	load_game()
	
