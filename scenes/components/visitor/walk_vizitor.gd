extends BaseStateVisitor

func enter()->void:
	player.dissatisfaction.hide()
	return




func physics_procces(delta: float)->int:
	if player.path == []:
		if player.room == null:
			player.queue_free()
			return State.IDLE
		return State.IDLEEVENT
	return State.NULL
