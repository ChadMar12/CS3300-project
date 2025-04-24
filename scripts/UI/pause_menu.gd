extends Control
@onready var margin_container: MarginContainer = $MarginContainer
@onready var settings_menu: Options_Menu = $"Settings Menu"
@onready var proto_controller: CharacterBody3D = %ProtoController

func _process(_delta: float) -> void:
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

func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.player_position = proto_controller.global_position
	saved_game.character = level_manager.character_selected
	print(saved_game.player_position)
	print(saved_game.character)
	ResourceSaver.save(saved_game, "user://savegame.tres")

func _on_save_pressed() -> void:
	save_game()

func _on_resume_pressed() -> void:
	Engine.time_scale = 1
	self.hide() # Hides the pause menu UI
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
