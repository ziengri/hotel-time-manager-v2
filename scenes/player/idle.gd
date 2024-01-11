extends BaseState



func enter()->void:
	player.animState.travel("Idle")


func input(event: InputEvent) -> int:
	if just_move_pressed():
		return State.WALK
	return State.NULL


func physics_procces(delta: float)->int:
	if move_pressed():
		return State.WALK
	return State.NULL
