extends BTLeaf
@onready var queue_composite :BTComposite

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if (_actor as VisitorCharacter).room == null:
		return BTStatus.RUNNING
	else:
		Rel.queue.queue_hotel[queue_composite.queue_number]['visitor'] = null
		return BTStatus.SUCCESS
