extends BTLeaf

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if (_actor as VisitorCharacter).is_event_active:
		return BTStatus.RUNNING
	
	return emit_event(_actor)



func emit_event(_actor: Node):
	if (_actor as VisitorCharacter).event_count <=0:
		(_actor.room as Room).status = Room.RoomStatus.DIRTY
		_actor.room = null
		(_actor as VisitorCharacter).target_path = Rel.world.find_path(_actor.global_position,Vector2(660,80))
		return BTStatus.SUCCESS
	(_actor as VisitorCharacter).room.generate_event(_actor)
	(_actor as VisitorCharacter).event_count -= 1
	(_actor as VisitorCharacter).is_event_active = true
	return BTStatus.RUNNING




