extends Area2D
class_name Room


enum RoomStatus{
	FREE,
	BUSY,
	DIRTY,
	CLOSED
}

@export var status : RoomStatus 
@export var room_number : int = 0
@onready var event_sources :Array[Area2D]


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rooms")
	await get_tree().create_timer(0.2).timeout
	event_sources = get_overlapping_areas() as Array[Area2D]
	print(event_sources)
	for event_source in event_sources:
		event_source.event_key = event_source.event_key + "_" + str(room_number) 
		print(event_source.event_key)
		EventManager.event_sources[event_source.event_key] =  event_source


#func _physics_process(delta):
	#print(get_overlapping_areas())

func generate_event():
	var event_info :EventInfo = EventManager.event_infos['room_events'].pick_random()
	EventManager.add_event(self,event_info.event_key+ "_" + str(room_number) ,event_info)
