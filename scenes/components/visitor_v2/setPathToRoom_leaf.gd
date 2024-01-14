extends BTLeaf



# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	_actor.target_path = Rel.world.find_path(_actor.global_position,_actor.room.global_position)
	return BTStatus.SUCCESS





