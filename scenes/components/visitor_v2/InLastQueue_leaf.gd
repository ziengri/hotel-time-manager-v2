extends BTLeaf
@onready var queue_composite :BTComposite

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if (_actor as VisitorCharacter).room == null:
		return BTStatus.RUNNING
	else:
		Rel.queue.queue_hotel[queue_composite.queue_number]['visitor'] = null
		_actor.target_path = Rel.world.find_path(_actor.global_position,_actor.room.global_position)
		return BTStatus.SUCCESS
