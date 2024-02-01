extends Panel
class_name EventCard


@onready var event_alias  :Label =  $TextureRect/VBoxContainer/EventAlias
@onready var room_number  :Label =  $TextureRect/VBoxContainer/RoomNumber
@onready var progress_bar  :ProgressBar = $TextureRect/VBoxContainer/ProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect = $TextureRect

var event_info
var room_id : int

func _ready()->void:
	texture_rect.modulate.a = 0
	event_alias.text = (event_info['event_info'] as EventInfo).description
	room_number.text = "Комната: " + str(room_id)
	if event_info['timer'] !=null:
		progress_bar.max_value = int(event_info['timer'].wait_time)
	else:
		progress_bar.visible = false

	create_tween()
	animation_player.play("1")

func _process(delta):
	if event_info['timer'] !=null:
		progress_bar.value = int(event_info['timer'].time_left)

func delete():
	set_process(false)
	animation_player.play("2")

