extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var queue : Queue = get_tree().get_current_scene().get_node("Queue") as Queue
	if queue.queue_hotel[queue.max_queue-1]['visitor']==null :
		get_parent()._cancel()
		return

	var rooms :Array[Node] = get_tree().get_nodes_in_group("rooms") as Array[Node]
	var free_rooms :Array[Room] = get_free_rooms(rooms)

	if free_rooms == [] : 
		get_parent()._fail()
		return
	
	var visitor = queue.queue_hotel[queue.max_queue-1]['visitor']
	
	visitor.room = free_rooms.pick_random()
	visitor.room.status = Room.RoomStatus.BUSY 
	visitor.path = visitor.calculate_path(visitor.room.global_position)
	visitor.states.change_state(BaseStateVisitor.State.WALK)
	queue.queue_hotel[queue.max_queue-1]['visitor']=null
	get_parent()._finish()

	

func get_free_rooms(rooms :Array[Node])-> Array[Room] :
	var free_rooms :Array[Room] = []
	for room in rooms:
		if(room.status == Room.RoomStatus.FREE):free_rooms.append(room)
	return free_rooms
	
