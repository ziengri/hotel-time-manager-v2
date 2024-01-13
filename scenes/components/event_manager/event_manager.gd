extends Node


var event_infos : Dictionary = {}
var eventList :Dictionary = {} 
var event_sources :Dictionary = {} 
signal event_list_removed
signal event_list_added


func _ready():
	var event_types_path : String = "res://scenes/components/event_manager/events/"
	var event_types : PackedStringArray =  DirAccess.open(event_types_path).get_directories()
	print(event_types)
	for event_type in event_types:
		event_infos[event_type] = {}
		for load_event_info in (DirAccess.open(event_types_path+event_type).get_files() as PackedStringArray):	
			var event_info :EventInfo =load(event_types_path+event_type+"/"+load_event_info) as EventInfo
			event_infos[event_type][event_info.event_key]=event_info
	print(event_infos)
			
func add_event(source_link,event_source_key,event_info:EventInfo,visitor:CharacterBody2D = null)->void:
	
	var timer : Timer = create_timer(event_info.time_to_event)
	timer.timeout.connect(on_event_fail.bind(event_source_key))
	add_child(timer)
	if event_info.time_to_event != 0:timer.start()
	var event_source_node :EventSource = event_sources[event_source_key] as EventSource
	event_source_node.action_finish.connect(finish_event)
	event_source_node.status = EventSource.Status.ACTIVE
	
	eventList[event_source_key]={"source_link":source_link,"event_source_node":event_source_node,"timer":timer,"event_info":event_info}
	
	if(event_info.is_in_room):
		eventList[event_source_key]["visitor"]=visitor


	print(eventList)
	event_list_added.emit(eventList[event_source_key])



func finish_event(event_source_key)->void:
	if eventList[event_source_key]["visitor"] != null:
		eventList[event_source_key]["visitor"].states.change_state(BaseStateVisitor.State.IDLEEVENT) 
		
	event_list_removed.emit(eventList[event_source_key])
	give_reward((eventList[event_source_key]["event_info"] as EventInfo).reward)
	remove_event_from_list(event_source_key)
	#print(eventList)


func remove_event_from_list(event_source_key)->void:

	var event_timer : Timer = eventList[event_source_key]['timer']
	event_timer.timeout.disconnect(on_event_fail) 
	event_timer.queue_free()
	(event_sources[event_source_key] as EventSource).status = EventSource.Status.NONACTIVE
	eventList.erase(event_source_key)



func add_to_eventList(room,event_info:EventInfo,timer:Timer)->void:
	pass


func on_event_fail(event_source_key)->void:
	if eventList[event_source_key]['event_source_node'].active_scene != null :
			(eventList[event_source_key]['event_source_node'] as EventSource).active_scene._cancel()

	Stats.stars -=1

func give_reward(reward_count) ->void:
	Stats.money += reward_count


func create_timer(wait_time:float)->Timer:
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = wait_time
	return timer
