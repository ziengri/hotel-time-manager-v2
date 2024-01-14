extends BTLeaf

#var waiting : bool =false
# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if not (_actor as VisitorCharacter).is_event_active:
		#FIXME Наверняя можно улушчить таймер 
		#if waiting
		if (_actor as VisitorCharacter).event_count <=0:
			return BTStatus.SUCCESS
		(_actor as VisitorCharacter).room.generate_event(_actor)
		(_actor as VisitorCharacter).event_count -= 1
		(_actor as VisitorCharacter).is_event_active = true
		return BTStatus.RUNNING
	else:
		return BTStatus.RUNNING

#func start_waiting(wait_time)->void:
	#var timer:Timer = Timer.new()
	#timer.wait_time = randi_range(5,15)
	#timer.timeout.connect(on_timer_timeout)
	#timer.start()
	#
#func on_timer_timeout() ->void:
	#pass
	#




