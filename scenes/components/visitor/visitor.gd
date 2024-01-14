extends CharacterBody2D
class_name VisitorCharacter

@export var move_speed : float = 50
@export var MAX_SPEED : float = 50
@export var state_machine: FiniteStateMachine
@export var behaviour_tree: BTRoot

var event_count : int = 0
var room : Room = null
var is_event_active:bool = false

var target_path :Array = []

func _physics_process(delta):
	return
	print(state_machine.active_state)
