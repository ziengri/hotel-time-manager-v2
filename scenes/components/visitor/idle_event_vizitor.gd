extends BaseStateVisitor

@onready var event_timer : Timer = $EventTimer as Timer 

func _ready():
	event_timer.timeout.connect(start_event)

func enter()->void:
	event_timer.start(randi_range(5,15))
	
func start_event()->void:
	
	if player.event_count <= 0:
		print_debug("Возможно перенести выше в посетителя")
		player.room.status = Room.RoomStatus.DIRTY
		player.room.visitor = null
		player.room = null
		player.path = player.world.find_path(player.tile_map.local_to_map(  player.position  ) , Vector2i.ONE  )
		get_parent().change_state(BaseStateVisitor.State.WALK)
	else:
		player.event_count -=1
		player.room.generate_event()
		get_parent().change_state(BaseStateVisitor.State.IDLE)


