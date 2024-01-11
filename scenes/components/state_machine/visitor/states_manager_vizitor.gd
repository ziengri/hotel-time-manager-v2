class_name StateMachineVizitor
extends Node



@export var STATES: Dictionary

func _ready():
	for node_path in get_children():
		var StateName = node_path.name.to_upper()
		STATES[BaseStateVisitor.State.get(StateName)] = node_path

var current_state:BaseStateVisitor

func change_state(nev_state: int) -> void:
	if current_state:
		current_state.exit()
	
	
	current_state = STATES[nev_state]
	current_state.enter()
	
	status_output(current_state)

func status_output(current_state):
	pass

func init(player) -> void:
	for child in get_children():
		child.player = player
	
	change_state(BaseStateVisitor.State.IDLE)

func physics_process(delta: float) -> void:
	var new_state = current_state.physics_procces(delta)
	if new_state != BaseStateVisitor.State.NULL:
		change_state(new_state)

func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state != BaseStateVisitor.State.NULL:
		change_state(new_state)
