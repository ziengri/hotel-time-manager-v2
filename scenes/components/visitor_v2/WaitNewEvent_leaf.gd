extends BTLeaf
class_name BTTimer

@export_category("Wait time")
@export var wait_time : float = 0
@export_category("Range Wait time")
@export var random_in_range: bool =false
@export var from : float = 0
@export var to : float = 0
var timer_finished :bool = false
var timer :Timer 



func tick(_delta: float, _actor: Node, _blackboard: Blackboard) -> BTStatus:
	if !timer_finished and timer == null:
		timer = Timer.new()
		timer.autostart = true
		timer.wait_time = get_time()
		timer.timeout.connect(_on_timer_timeout)
		add_child(timer)
		return BTStatus.RUNNING
	
	if timer_finished and timer !=null:
		timer_finished = false
		timer.queue_free()
		timer = null
		return BTStatus.SUCCESS
	
	return BTStatus.RUNNING


func get_time() ->float:
	if random_in_range :
		return randf_range(from,to)
	else:
		return wait_time


func _on_timer_timeout():
	timer_finished = true
