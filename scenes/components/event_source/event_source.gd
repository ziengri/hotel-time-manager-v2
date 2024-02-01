extends Area2D
class_name EventSource

signal action_finish
signal action_failed

		
enum Status{
	ACTIVE,
	NONACTIVE
}


@export var status :Status = Status.NONACTIVE
@export var action_scene_path : PackedScene
@export var event_info : EventInfo


var event_key : String
var is_iteracting : bool = false
var active_scene:ActionScene

func _ready():
	if event_info:
		event_key = event_info.event_key
	else:
		print_debug("Event info in "+get_parent().name+" is null")


func interact():
	if status == Status.NONACTIVE or is_iteracting == true :return false
	active_scene = action_scene_path.instantiate() as ActionScene
	
	active_scene.finished.connect(_on_active_scene_finised)
	active_scene.canceled.connect(_on_active_scene_canceled)
	active_scene.failed.connect(_on_active_scene_failed)
	is_iteracting = true
	
	add_child(active_scene)
	
	

func _on_active_scene_finised()->void:
	reset_active_scene()
	action_finish.emit(event_key)

func _on_active_scene_canceled()->void:
	reset_active_scene()

func _on_active_scene_failed()->void:
	reset_active_scene()
	action_failed.emit(event_key)
	
func reset_active_scene()->void:
	is_iteracting = false
	if active_scene != null:
		active_scene.queue_free()
		active_scene = null

