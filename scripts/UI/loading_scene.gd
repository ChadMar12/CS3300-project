extends Control

var main_scene_path = "res://scene/game map/game_world.tscn"
var real_progress := 0.0
var display_progress := 0.0
var loading_started := false
var loading_done := false
var dot_state = 0

@onready var loading_label = $Loading
@onready var loading_bar = $ProgressBar
@onready var dot_timer = $Dot_timer

func _ready() -> void:
	ResourceLoader.load_threaded_request(main_scene_path)
	loading_started = true

func _process(delta: float) -> void:
	if loading_started and not loading_done:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(main_scene_path, progress)

		if progress.size() > 0:
			real_progress = progress[0]
		
		# Smooth visual progress using interpolation
		display_progress = lerp(display_progress, real_progress, 5 * delta)

		# Clamp to 1.0 if very close to 100%
		if abs(display_progress - real_progress) < 0.01:
			display_progress = real_progress

		# Update your UI
		loading_bar.value = display_progress * 100
		
		if status == ResourceLoader.THREAD_LOAD_LOADED and display_progress >= 0.99:
			loading_done = true
			loading_bar.value = 100.0				# Set bar to 100
			await get_tree().create_timer(0.5).timeout	# Small delay before switiching
			var scene = ResourceLoader.load_threaded_get(main_scene_path)
			get_tree().change_scene_to_packed(scene)

# funciton for creating the loading screen " . . . " animnation
func _on_dot_timer_timeout() -> void:
	dot_state = (dot_state + 1) % 4
	loading_label.text = "Loading" + ".".repeat(dot_state)
