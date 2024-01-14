extends BaseStateVisitor

@onready var world: World = get_tree().get_current_scene()
@onready var tile_map: TileMap = get_tree().get_current_scene().get_node("TileMap")
@onready var queue = get_tree().get_current_scene().get_node("Queue")

var queue_number: int = 0

func enter()->void:
	return
	#if queue.queue_hotel[queue_number]["free"] == true:
		#player.path = world.find_path(tile_map.local_to_map(player.position),queue.queue_hotel[queue_number]["pos"])
		#queue.queue_hotel[queue_number]["free"] = false

func physics_procces(delta: float)->int:

	
	if queue.max_queue == queue_number+1:
		if player.path == []:
			return State.WAIT
		return State.NULL
	
	if queue.queue_hotel[queue_number]["visitor"] == null:
		player.path = world.find_path(player.global_position,queue.queue_hotel[queue_number]["pos"])
		queue.queue_hotel[queue_number]["visitor"] = player
		State.NULL
	
	if queue.queue_hotel[queue_number+1]["visitor"] == null and tile_map.local_to_map(player.position) == tile_map.local_to_map(queue.queue_hotel[queue_number]["pos"]):
		change_in_queue()

	
	return State.NULL


func change_in_queue():
	player.path = world.find_path(player.global_position,queue.queue_hotel[queue_number+1]["pos"])
	queue_number += 1
	queue.queue_hotel[queue_number-1]["visitor"] = null
	queue.queue_hotel[queue_number]["visitor"] = player
