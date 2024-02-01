extends Node


var event_infos : Dictionary = {"room_events":{},"other_events":{}}
var eventList :Dictionary = {} 
var event_sources :Dictionary = {} 
signal event_list_removed
signal event_list_added


func _ready():
	var room_events :Array = (load("res://scenes/components/event_manager/events/room_events.tres") as ResourceGroup).load_all()
	var other_events :Array = (load("res://scenes/components/event_manager/events/other_events.tres") as ResourceGroup).load_all()
	
	for room_event in room_events:
		event_infos['room_events'][room_event.event_key] = room_event
	for other_event in other_events:
		event_infos['other_events'][other_event.event_key] = other_event

			
func add_event(source_link,event_info:EventInfo,visitor:CharacterBody2D = null)->Dictionary:
	var event_source_key = event_info.event_key
	if source_link is Room:
		event_source_key +=  "_" + str((source_link as Room).room_number)
	
	var timer : Timer = null
	
	if event_info.time_to_event > 0:
		timer = create_timer(event_info.time_to_event)
		timer.timeout.connect(on_event_timeout.bind(event_source_key))
		add_child(timer)
	

	var event_source_node :EventSource = event_sources[event_source_key] as EventSource
	event_source_node.action_finish.connect(finish_event)
	event_source_node.action_failed.connect(fail_event)

	event_source_node.status = EventSource.Status.ACTIVE
	
	eventList[event_source_key]={"source_link":source_link,"event_source_node":event_source_node,"timer":timer,"event_info":event_info,"visitor":visitor}


	print(eventList)
	event_list_added.emit(eventList[event_source_key])
	return eventList[event_source_key]



func finish_event(event_source_key)->void:	
	event_list_removed.emit(eventList[event_source_key])
	give_reward((eventList[event_source_key]["event_info"] as EventInfo).reward)
	remove_event_from_list(event_source_key)
	#print(eventList)

func fail_event(event_source_key)->void:	
	event_list_removed.emit(eventList[event_source_key])
	remove_event_from_list(event_source_key)
	Stats.stars -=1

	#print(eventList)


func remove_event_from_list(event_source_key)->void:
	var event_source_node :EventSource = event_sources[event_source_key] as EventSource
	event_source_node.action_finish.disconnect(finish_event)
	event_source_node.action_failed.disconnect(fail_event)
	
	if (eventList[event_source_key]['timer'] != null):
		var event_timer : Timer = eventList[event_source_key]['timer']
		event_timer.timeout.disconnect(on_event_timeout) 
		event_timer.queue_free()
	(event_sources[event_source_key] as EventSource).status = EventSource.Status.NONACTIVE
	eventList.erase(event_source_key)



func on_event_timeout(event_source_key)->void:
	var event_source_node: EventSource = eventList[event_source_key]['event_source_node'] as EventSource
	event_source_node._on_active_scene_failed()

	

func give_reward(reward_count) ->void:
	Stats.money += reward_count


func create_timer(wait_time:float)->Timer:
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = wait_time
	return timer
