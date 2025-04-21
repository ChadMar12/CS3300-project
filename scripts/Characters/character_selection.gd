extends Control

@onready var player_label = $player_description

## Functions for Knight to handle when the mouse enters the button, the animation " Cheer " will play and the player's label
## will show the information about the character.
func _on_knight_mouse_entered() -> void:
	$HBoxContainer/Knight/knight_preview/SubViewportContainer/SubViewport/Knight.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description: A disciplined warrior clad in heavy armor, the Knight excels 
							  in close combat and battlefield resilience. 
							
							  Combat Type: Melee
							  Health: 100
							  Armor: 50
							  Weapon: Sword')

func _on_knight_mouse_exited() -> void:
	$HBoxContainer/Knight/knight_preview/SubViewportContainer/SubViewport/Knight.set_move_state('Idle')
	player_label.hide()

func _on_knight_pressed() -> void:
	level_manager.character_selected = 'Knight'
	get_tree().change_scene_to_file('res://scene/ui/loading_scene.tscn')
	
	
## Functions for mage to handle when the mouse enters the button, the animation " Cheer " will play and the player's label
## will show the information about the character.
func _on_mage_mouse_entered() -> void:
	$HBoxContainer/Mage/mage_preview/SubViewportContainer/SubViewport/Mage.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description: A master of arcane arts cloaked in mystical robes, the Mage 
							  excels in long-range combat and elemental power.
							
							  Combat Type: Long Range Spell Bearer
							  Health: 75
							  Armor: 0
							  Weapon: Staff')

func _on_mage_mouse_exited() -> void:
	$HBoxContainer/Mage/mage_preview/SubViewportContainer/SubViewport/Mage.set_move_state('Idle')
	player_label.hide()

func _on_mage_pressed() -> void:
	level_manager.character_selected = 'Mage'
	get_tree().change_scene_to_file('res://scene/ui/loading_scene.tscn')
	

## Functions for barbarian to handle when the mouse enters the button, the animation " Cheer " will play and the player's label
## will show the information about the character.
func _on_barbarian_mouse_entered() -> void:
	$HBoxContainer/Barbarian/barbarian_preview/SubViewportContainer/SubViewport/Barbarian.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description: A fierce warrior driven by raw strength and primal fury, 
							  the Barbarian excels in brutal melee combat and relentless aggression.
							
							  Combat Type: Melee
							  Health: 125
							  Armor: 0
							  Weapon: Axe')

func _on_barbarian_mouse_exited() -> void:
	$HBoxContainer/Barbarian/barbarian_preview/SubViewportContainer/SubViewport/Barbarian.set_move_state('Idle')
	player_label.hide()
	
func _on_barbarian_pressed() -> void:
	level_manager.character_selected = 'Barbarian'
	get_tree().change_scene_to_file('res://scene/ui/loading_scene.tscn')


## Functions for  rouge to handle when the mouse enters the button, the animation " Cheer " will play and the player's label
## will show the information about the character.
func _on_rouge_mouse_entered() -> void:
	$HBoxContainer/Rouge/rouge_preview/SubViewportContainer/SubViewport/Rouge.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description: A cunning fighter shrouded in shadow, the Rogue excels in 
							  stealth, agility, and precision strikes.
							
							  Combat Type: Combo
							  Health: 100
							  Armor: 0
							  Weapon: CrossBow & Knife')

func _on_rouge_mouse_exited() -> void:
	$HBoxContainer/Rouge/rouge_preview/SubViewportContainer/SubViewport/Rouge.set_move_state('Idle')
	player_label.hide()

func _on_rouge_pressed() -> void:
	level_manager.character_selected = 'Rouge'
	get_tree().change_scene_to_file('res://scene/ui/loading_scene.tscn')


## Functions for druid to handle when the mouse enters the button, the animation " Cheer " will play and the player's label
## will show the information about the character.
func _on_druid_mouse_entered() -> void:
	$HBoxContainer/Druid/druid_preview/SubViewportContainer/SubViewport/Druid.set_move_state('Cheer')
	player_label.show()
	player_label.set_text('   Description: A guardian of nature and master of elemental balance, 
							  The Druid excels in adaptive magic and healing abilities.
							
							  Combat Type: Long Range Utility Spell Bearer
							  Health: 50
							  Armor: 25
							  Weapon: Healing Staff')

func _on_druid_mouse_exited() -> void:
	$HBoxContainer/Druid/druid_preview/SubViewportContainer/SubViewport/Druid.set_move_state('Idle')
	player_label.hide()

func _on_druid_pressed() -> void:
	level_manager.character_selected = 'Druid'
	get_tree().change_scene_to_file('res://scene/ui/loading_scene.tscn')
