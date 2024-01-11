class_name  BaseState
extends Node

enum State{
	NULL,
	IDLE,
	WALK,
	DASH,
	PATROL,
	ENGADE,
	ATTACK,
	SLIP,
	WALKSLIP,
	QUEUE,
	WAIT,
	IDLEEVENT
}

var player:CharacterBody2D

func enter()->void:
	pass
	
func exit()->void:
	pass
	
func input(event:InputEvent)->int:
	return State.NULL
	
func procces(delta: float)->int:
	return State.NULL
	
func physics_procces(delta: float)->int:
	return State.NULL






func just_move_pressed() -> bool:
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		return true
	else: return false

func move_pressed() -> bool:
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		return true
	else: return false

func get_input_vector() -> Vector2:
	var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	return input_vector

