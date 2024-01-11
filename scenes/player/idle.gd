extends BaseState



func enter()->void:
	player.animState.travel("Idle")


func input(event: InputEvent) -> int:
	if get_input_vector() != Vector2.ZERO: return State.WALK
	return State.NULL


func physics_procces(delta: float)->int:
	if get_input_vector() != Vector2.ZERO: return State.WALK
	return State.NULL
