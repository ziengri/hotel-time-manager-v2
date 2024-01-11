extends Panel
class_name EventCard


@onready var event_alias  :Label =  $TextureRect/VBoxContainer/EventAlias
@onready var room_number  :Label =  $TextureRect/VBoxContainer/RoomNumber
@onready var progress_bar  :ProgressBar = $TextureRect/VBoxContainer/ProgressBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var event_info
var room_id : int

func _ready()->void:
	event_alias.text = (event_info['event_info'] as EventInfo).description
	room_number.text = "Комната: " + str(room_id)
	progress_bar.max_value = int(event_info['timer'].wait_time)

	create_tween()
	animation_player.play("1")

func _process(delta):
	progress_bar.value = int(event_info['timer'].time_left)

func delete():
	set_process(false)
	animation_player.play("2")

