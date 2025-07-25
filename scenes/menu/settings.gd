extends Node2D

const UI_SCALE_OPTIONS : Array[float] = [1.0, 1.5, 2.0]

var volume_loading : bool = false

func _ready() -> void:
	for option in range(UI_SCALE_OPTIONS.size()):
		if is_equal_approx(Globals.ui_scale, UI_SCALE_OPTIONS[option]):
			$CanvasLayer/Settings/UIScale/UIScaleOption.select(option)
	$CanvasLayer/Settings/Particles/ParticlesOption.button_pressed = Globals.particles
	$CanvasLayer/Settings/Light/LightOption.button_pressed = Globals.light
	volume_loading = true
	$CanvasLayer/Settings/Volume/VolumeOption.value = Globals.volume
	volume_loading = false

func _on_ui_scale_option_item_selected(index: int) -> void:
	Globals.ui_scale = UI_SCALE_OPTIONS[index]

func _on_particles_option_toggled(toggled_on: bool) -> void:
	Globals.particles = toggled_on

func _on_light_option_toggled(toggled_on: bool) -> void:
	Globals.light = toggled_on

func _on_volume_option_value_changed(value: float) -> void:
	Globals.volume = value
	$CanvasLayer/Settings/Volume/Value.text = str(value)
	if !volume_loading:
		$AudioStreamPlayer2D.play()

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
