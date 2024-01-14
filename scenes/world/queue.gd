extends Node
class_name Queue

var queue_hotel: Array



func _ready():
	Rel.queue = self
	for child in get_children():
		#var pos = tile_map.local_to_map( get_child(child).position )
		queue_hotel.append({"pos": child.position, "visitor": null}) 
	#print(queue_hotel[-1])
