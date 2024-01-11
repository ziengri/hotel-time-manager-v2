extends BaseStateVisitor


@onready var timer: Timer = $Timer


func enter()->void:
	player.dissatisfaction.show()
	timer.start(60)
	player.dissatisfaction.max_value = timer.wait_time
	return


@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"


func _on_interact_area_interacted():
	var rooms:Array[Node] = get_tree().get_nodes_in_group("rooms") as Array[Node]
	var free_rooms :Array[Node] 

	for room in rooms:
		if room.status == Room.RoomStatus.FREE:
			free_rooms.append(room)
		
	if free_rooms.size() > 0:
		player.room = free_rooms.pick_random() as Node
		
		player.room.visitor = player
		player.room.status = Room.RoomStatus.BUSY
		#CHANGE STATE
		player.queue.queue_hotel[$"../Queue".queue_number]["free"] = true
		
		player.path = player.world.find_path(  player.tile_map.local_to_map(  player.position  ) , player.tile_map.local_to_map(  player.room.room_position.global_position  ))
		get_parent().change_state(BaseStateVisitor.State.WALK)
		animation_player.play("monitor_off")
		timer.set_paused(true) 
	
	else:
		print_debug("UI сообщение нету комнат")
		#UI сообщение нету комнат
		pass

func physics_procces(delta: float)->int:
	player.dissatisfaction.value = timer.time_left
	return BaseState.State.NULL

	
func _on_timer_timeout():
	animation_player.play("monitor_off")
	player.path = player.world.find_path(  (player.tile_map.local_to_map(  player.position  )+Vector2i(-1,0)) , Vector2i.ONE)
	get_parent().change_state(BaseStateVisitor.State.WALK)
	player.queue.queue_hotel[$"../Queue".queue_number]["free"] = true
