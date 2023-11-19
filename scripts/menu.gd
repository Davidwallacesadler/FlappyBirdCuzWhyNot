extends Control

@export var new_game_button: Button
@export var quit_button: Button

func _ready():
	new_game_button.pressed.connect(func(): GameEvents.new_game.emit())
	quit_button.pressed.connect(func(): GameEvents.quit_game.emit())
	
