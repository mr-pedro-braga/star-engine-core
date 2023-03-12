extends Resource
class_name BattleInstance

##Class that contains an instance of a battle. Used by BattleCore.

##An array containing the ally Characters.
@export var allies : Array[Character] = []
##An array containing the opponent Characters.
@export var opponents : Array[Character] = []
var opponent_scripts : Array[BattlerScript]
##Useful array containing both the allies and opponents.
var battlers : Array[Character] = []
##An array containing the current targets of the last executed action.
var current_targets := []

##The index of the turn the battle is currently at.
var turn_index := 0

##The actions chosen by the player to be executed.
var turn_ally_choices : Array = []

## Sets up the battle.
func setup():
	if allies.is_empty():
		allies = Game.get_party()
	
	opponent_scripts = []
	for opp in opponents:
		var n = opp.battler_script.new()
		n.battle = self
		opponent_scripts.append(n)
		Game.Battle.add_child(n)
	
	battlers.assign(allies + opponents)

func _to_string():
	return "{" + str(allies) + " v.s. " + str(opponents) +  "}"
