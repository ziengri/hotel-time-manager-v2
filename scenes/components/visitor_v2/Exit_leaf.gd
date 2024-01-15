extends BTLeaf


# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if _actor.target_path != []:
		#print("Иду к точке")
		return BTStatus.RUNNING
	else:
		_actor.queue_free()
		return BTStatus.SUCCESS
	
	




