extends BTLeaf

@onready var queue_composite :BTComposite

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	#Назначени первой очереди
	if (_actor as VisitorCharacter).target_path != []:
		#print("Иду к точке")
		return BTStatus.RUNNING
	
	if queue_composite.queue_number == Rel.queue.queue_hotel.size()-1:
		return BTStatus.SUCCESS
	
	if Rel.queue.queue_hotel[queue_composite.queue_number+1]['visitor'] == null:
		Rel.queue.queue_hotel[queue_composite.queue_number+1]['visitor'] =  _actor
		Rel.queue.queue_hotel[queue_composite.queue_number]['visitor'] =  null
		queue_composite.queue_number += 1
		#print('Теперь я на',queue_composite.queue_number+1)
		(_actor as VisitorCharacter).target_path = Rel.world.find_path(_actor.global_position,Rel.queue.queue_hotel[queue_composite.queue_number]['pos'])
		return BTStatus.RUNNING
	else:
		return BTStatus.RUNNING
	
	




