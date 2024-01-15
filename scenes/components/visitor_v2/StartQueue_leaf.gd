extends BTLeaf

@onready var queue_composite :BTComposite

# Gets called every tick of the behavior tree
func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	#Назначени первой очереди
	if Rel.queue.queue_hotel[0]['visitor'] == null:
		Rel.queue.queue_hotel[0]['visitor'] =  _actor
		queue_composite.queue_number = 0
		_actor.target_path = Rel.world.find_path(_actor.global_position,Rel.queue.queue_hotel[0]['pos'])
		return BTStatus.SUCCESS
	else:
		return BTStatus.RUNNING
	




#
#func enter()->void:
	#return
	##if queue.queue_hotel[queue_number]["free"] == true:
		##player.path = world.find_path(tile_map.local_to_map(player.position),queue.queue_hotel[queue_number]["pos"])
		##queue.queue_hotel[queue_number]["free"] = false
#
#func physics_procces(delta: float)->int:
#
	#
	#if queue.max_queue == queue_number+1:
		#if player.path == []:
			#return State.WAIT
		#return State.NULL
	#
	#if queue.queue_hotel[queue_number]["visitor"] == null:
		#player.path = world.find_path(player.global_position,queue.queue_hotel[queue_number]["pos"])
		#queue.queue_hotel[queue_number]["visitor"] = player
		#State.NULL
	#
	#if queue.queue_hotel[queue_number+1]["visitor"] == null and tile_map.local_to_map(player.position) == tile_map.local_to_map(queue.queue_hotel[queue_number]["pos"]):
		#change_in_queue()
#
	#
	#return State.NULL
#
#
#func change_in_queue():
	#player.path = world.find_path(player.global_position,queue.queue_hotel[queue_number+1]["pos"])
	#queue_number += 1
	#queue.queue_hotel[queue_number-1]["visitor"] = null
	#queue.queue_hotel[queue_number]["visitor"] = player
