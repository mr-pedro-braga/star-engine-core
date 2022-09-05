extends __EventBase
class_name StarScriptEvent
@icon("icon_dialogevent.png")

@export var event_pool : Resource
@export var event_key : String = ""

func _trigger():
	if Game.DC.is_in_cutscene:
		return
	await get_tree().process_frame
	
	Game.DC.enter_cutscene()
	
	if not event_pool.data.has(event_key):
		Shell.print_err(
			"MissingKey", "The key " + str(event_key) +\
			" wasn't found in the pool " + str(event_pool) + "."
			)
	
	await Shell.execute_block(event_pool.data[event_key].content)
	Game.DC.exit_cutscene()
