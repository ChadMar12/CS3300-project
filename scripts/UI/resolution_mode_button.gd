extends Control


@onready var option_button: OptionButton = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DIC : Dictionary = {
	'1152 x 648': Vector2i(1152,648),
	'1280 x 720' : Vector2i(1280,720),
	'1920 x 1080': Vector2i(1920,1080),
	'2560 x 1440': Vector2i(2560,1440)
}

func _ready() -> void:
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_item()


func add_resolution_item() -> void:
	for res_size_text in RESOLUTION_DIC:
		option_button.add_item(res_size_text)


func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DIC.values()[index])
