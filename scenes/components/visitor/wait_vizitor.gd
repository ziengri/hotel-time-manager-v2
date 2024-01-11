extends BaseStateVisitor


@onready var timer: Timer = $Timer
@onready var queue = $"../Queue"


func enter()->void:
	player.dissatisfaction.show()
	timer.start(60)
	player.dissatisfaction.max_value = timer.wait_time
	return

func exit()->void:
	timer.stop()

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"



func physics_procces(delta: float)->int:
	player.dissatisfaction.value = timer.time_left
	return BaseState.State.NULL

	
func _on_timer_timeout():
	animation_player.play("monitor_off")
	player.path = player.world.find_path(  (player.tile_map.local_to_map(  player.position  )+Vector2i(-1,0)) , Vector2i.ONE)
	get_parent().change_state(BaseStateVisitor.State.WALK)
	player.queue.queue_hotel[queue.queue_number]["vizitor"] = null
