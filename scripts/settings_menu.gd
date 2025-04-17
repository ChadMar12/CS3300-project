class_name Options_Menu
extends Control

@onready var exit: Button = $MarginContainer/VBoxContainer/exit

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/main_menu.tscn")
