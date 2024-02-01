extends BTLeaf

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	(_actor as VisitorCharacter).room.generate_event(_actor)
	(_actor as VisitorCharacter).is_event_active = true
	return BTStatus.RUNNING







