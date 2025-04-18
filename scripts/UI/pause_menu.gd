extends Control
@onready var margin_container: MarginContainer = $MarginContainer
@onready var settings_menu: Options_Menu = $"Settings Menu"

func _process(delta: float) -> void:
	optionsMenu()

func _on_options_pressed() -> void:
	margin_container.hide()
	settings_menu.show()

func optionsMenu() -> void:
	if settings_menu.visible == true and Input.is_action_just_pressed("pause"):
		settings_menu.hide()
		margin_container.show()
	else:
		margin_container.show()
		
func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ui/main_menu.tscn")
