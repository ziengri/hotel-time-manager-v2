extends Area2D
class_name EventSource

signal action_finish

enum Status{
	ACTIVE,
	NONACTIVE
}
#//Сеттер для стрелочки.подсвечивание
@export_enum("Default","Room_cleaning","need_food") var event_key : String
@export var action_scene_path : PackedScene

var is_iteracting : bool = false
var active_scene:ActionScene
@export var status :Status = Status.NONACTIVE

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
	
func reset_active_scene()->void:
	active_scene.queue_free()
	active_scene = null
	is_iteracting = false
