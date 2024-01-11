extends Node


var eventList :Dictionary = {} 
var event_sources :Dictionary = {} 
signal event_list_removed
signal event_list_added


func add_event(event_source_key,event_info:EventInfo,visitor:CharacterBody2D = null)->void:
	
	var timer : Timer = create_timer(event_info.time_to_event)
	timer.timeout.connect(on_event_fail.bind(event_source_key))
	add_child(timer)
	var event_source_node :EventSource = event_sources[event_source_key] as EventSource
	event_source_node.action_finish.connect(finish_event)
	
	eventList[event_source_key]={"timer":timer,"event_info":event_info}
	
	if(event_info.is_in_room):
		eventList[event_source_key]["visitor"]=visitor


	
	event_list_added.emit()



func finish_event(event_source_key)->void:
	if (eventList[event_source_key]["event_info"] as EventInfo).is_in_room:
		#(eventList[event_source_key]["visitor"] as CharacterBody2D).change_state()
		pass
	give_reward((eventList[event_source_key]["event_info"] as EventInfo).reward)
	remove_event_from_list(event_source_key)
	#print(eventList)


func remove_event_from_list(event_source_key)->void:
	var event_timer : Timer = eventList[event_source_key]['timer']
	event_timer.timeout.disconnect(on_event_fail) 
	event_timer.queue_free()
	(eventList[event_source_key] as EventSource).status = EventSource.Status.NONACTIVE
	eventList.erase(event_source_key)
	event_list_removed.emit()


func add_to_eventList(room,event_info:EventInfo,timer:Timer)->void:
	pass


func on_event_fail(event_source_key)->void:
	(eventList[event_source_key] as EventSource).active_scene._cancel()
	Stats.stars -=1

func give_reward(reward_count) ->void:
	Stats.money += reward_count


func create_timer(wait_time:float)->Timer:
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = wait_time
	return timer