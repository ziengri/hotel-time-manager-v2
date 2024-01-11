extends Node

@onready var tile_map: TileMap = get_tree().get_current_scene().get_node("TileMap")
var queue_hotel: Dictionary
var max_queue: int


func _ready():
	max_queue = get_children().size()
	for child in get_children().size():
		var pos = tile_map.local_to_map( get_child(child).position )
		queue_hotel[child] = {"pos": pos, "free": true}
	print(queue_hotel)
