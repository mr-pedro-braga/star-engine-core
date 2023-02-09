@icon("res://_engine/scripts/icons/icon_core_game.png")
extends Control
class_name GameInstance

## Class that encapsulates an instance of a game,.
##
## It loads Core nodes from the scene tree plus
## handle some things.
##
## Instead of instantiating this class, you should
## probably [i]write your own[/i].

@export_category("Cores")
@export var audio_core : AudioCore
@export var dialog_cutscene_core : DialogCutsceneCore
@export var data_core : DataCore
@export var battle_core : BattleCore

@export_category("Setup")
@export var first_room : PackedScene

func _ready():
	if CustomRunner.is_custom_running():
		var scene := load(CustomRunner.get_variable("scene"))
		first_room = scene
		print("Starting game at %s." % scene.resource_path)
	
	# Set up the Cores in [Game]
	
	if audio_core:
		Game.Audio = (audio_core)
	if data_core:
		Game.Data = (data_core)
	if dialog_cutscene_core:
		Game.DC = (dialog_cutscene_core)
	if battle_core:
		Game.Battle = (battle_core)
	
	start.call_deferred()

func start():
	print ("Setting up game.")
	
	# Load the first game room (or the main menu)
	Game.change_room(first_room)

var _window_mode_before_fullscreen := Window.MODE_MINIMIZED
func _input(ev):
	if Input.is_action_just_pressed("ui_fullscreen"):
		var w : Window = get_tree().root
		if w.mode == Window.MODE_FULLSCREEN:
			w.mode = _window_mode_before_fullscreen
		else:
			_window_mode_before_fullscreen = w.mode
			w.mode = Window.MODE_FULLSCREEN
