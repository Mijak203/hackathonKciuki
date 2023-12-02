extends CanvasLayer

@onready var setting_screen = $setting_screen
func _on_start_pressed():
	get_tree().change_scene_to_file("res://levels/level_1.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://levels/settings.tscn")

