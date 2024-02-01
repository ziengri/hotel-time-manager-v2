extends BTLeaf
class_name BTEventLeaf

@export var event_info : EventInfo

enum EVENT {
	NONACTIVE,
	ACTIVE,
	FAILED,
	FINISHED
}
var event_status : EVENT = EVENT.NONACTIVE

func tick(_delta: float, actor: Node, _blackboard: Blackboard):
	# print("TICK_____")

	match event_status:
		EVENT.NONACTIVE:
			var event_in_list :Dictionary = (actor as VisitorCharacter).room.start_event(event_info,actor)
			var event_source_node : EventSource = event_in_list["event_source_node"] 
			event_source_node.action_finish.connect(on_finish_event)
			event_source_node.action_failed.connect(on_fail_event)
			event_status= EVENT.ACTIVE
			return BTStatus.RUNNING
		EVENT.ACTIVE:
			return BTStatus.RUNNING
		EVENT.FAILED:
			event_status = EVENT.NONACTIVE
			return BTStatus.FAILURE
		EVENT.FINISHED:
			event_status = EVENT.NONACTIVE
			return BTStatus.SUCCESS
	
	return BTStatus.RUNNING



func on_finish_event(event_source_key):
	print("EVENT FINISH")
	signal_disconnect(event_source_key)
	event_status = EVENT.FINISHED
	
func on_fail_event(event_source_key):
	print("EVENT FAIL")
	signal_disconnect(event_source_key)
	event_status = EVENT.FAILED
	
func signal_disconnect(event_source_key):
	(EventManager.event_sources[event_source_key] as EventSource).action_failed.disconnect(on_fail_event)
	(EventManager.event_sources[event_source_key] as EventSource).action_finish.disconnect(on_finish_event)
