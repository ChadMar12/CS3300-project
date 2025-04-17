extends Control

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/character_selection.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/settings_menu.tscn")
