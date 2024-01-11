extends Node

signal stars_over
signal stats_changed

var player :CharacterBody2D 

@export var money : int = 0 : set = set_money
func set_money(new_value):
	money = max(0,new_value)
	stats_changed.emit()

const max_stars : int = 5
@export var stars :int = 5 : set = set_stars

func set_stars(new_value):
	if(new_value<= 0):
		game_over()
	stars = max(0,min(max_stars,new_value))
	stats_changed.emit()
	
func _ready()->void:
	player = get_tree().get_first_node_in_group("player")	
	
func game_over()->void:
	var a = InputEventAction.new()
	a.action = "game_over"
	a.pressed = true
	Input.parse_input_event(a)

