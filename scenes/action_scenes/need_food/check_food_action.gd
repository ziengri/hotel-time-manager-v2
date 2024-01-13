extends ActionScene


# Called when the node enters the scene tree for the first time.
func _ready():
	print(Stats.player.object_in_hands)
	if Stats.player.object_in_hands == Stats.player.ObjectHold.FOOD:
		Stats.player.object_in_hands = Stats.player.ObjectHold.NONE
		_finish()
	else:
		_cancel()


