extends Control

@onready var player_label = $player_description

func _on_knight_pressed() -> void:
	level_manager.character_selected = 'Knight'
	get_tree().change_scene_to_file("res://scene/game map/game_world.tscn")


func _on_mage_pressed() -> void:
	level_manager.character_selected = 'Mage'
	get_tree().change_scene_to_file("res://scene/game map/game_world.tscn")


func _on_barbarian_pressed() -> void:
	level_manager.character_selected = 'Barbarian'
	get_tree().change_scene_to_file("res://scene/game map/game_world.tscn")


func _on_rouge_pressed() -> void:
	level_manager.character_selected = 'Rouge'
	get_tree().change_scene_to_file("res://scene/game map/game_world.tscn")


func _on_druid_pressed() -> void:
	level_manager.character_selected = 'Druid'
	get_tree().change_scene_to_file("res://scene/game map/game_world.tscn")


func _on_knight_mouse_entered() -> void:
	$HBoxContainer/Knight/knight_preview/SubViewportContainer/SubViewport/Knight.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description:
							
							  Combat Type:
							  Health:
							  Armor:
							  Weapon:')



func _on_knight_mouse_exited() -> void:
	$HBoxContainer/Knight/knight_preview/SubViewportContainer/SubViewport/Knight.set_move_state('Idle')
	player_label.hide()


func _on_mage_mouse_entered() -> void:
	$HBoxContainer/Mage/mage_preview/SubViewportContainer/SubViewport/Mage.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description:
							
							  Combat Type:
							  Health:
							  Armor:
							  Weapon:')


func _on_mage_mouse_exited() -> void:
	$HBoxContainer/Mage/mage_preview/SubViewportContainer/SubViewport/Mage.set_move_state('Idle')
	player_label.hide()


func _on_barbarian_mouse_entered() -> void:
	$HBoxContainer/Barbarian/barbarian_preview/SubViewportContainer/SubViewport/Barbarian.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description:
							
							  Combat Type:
							  Health:
							  Armor:
							  Weapon:')


func _on_barbarian_mouse_exited() -> void:
	$HBoxContainer/Barbarian/barbarian_preview/SubViewportContainer/SubViewport/Barbarian.set_move_state('Idle')
	player_label.hide()


func _on_rouge_mouse_entered() -> void:
	$HBoxContainer/Rouge/rouge_preview/SubViewportContainer/SubViewport/Rouge.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description:
							
							  Combat Type:
							  Health:
							  Armor:
							  Weapon:')


func _on_rouge_mouse_exited() -> void:
	$HBoxContainer/Rouge/rouge_preview/SubViewportContainer/SubViewport/Rouge.set_move_state('Idle')
	player_label.hide()


func _on_druid_mouse_entered() -> void:
	$HBoxContainer/Druid/druid_preview/SubViewportContainer/SubViewport/Druid.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description:
							
							  Combat Type:
							  Health:
							  Armor:
							  Weapon:')


func _on_druid_mouse_exited() -> void:
	$HBoxContainer/Druid/druid_preview/SubViewportContainer/SubViewport/Druid.set_move_state('Idle')
	player_label.hide()
