extends Camera2D

@onready var navigition_arrow_scene :PackedScene =  preload("res://scenes/components/navigation_arrow/navigation_arrow.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.event_list_added.connect(on_event_list_added)
	EventManager.event_list_removed.connect(event_list_removed)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_event_list_added(event_in_list)->void:
	var new_navigation_arrow = navigition_arrow_scene.instantiate()
	new_navigation_arrow.target = event_in_list['event_source_node']
	new_navigation_arrow.event = event_in_list
	add_child(new_navigation_arrow)
	
func event_list_removed(event_in_list)->void:
	for arrow in get_children():
		if arrow.event == event_in_list:
			arrow.queue_free()
