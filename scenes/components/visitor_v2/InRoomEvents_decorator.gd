extends BTRepeat


@onready var bt_root : BTRoot = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	repetition = bt_root.actor.event_number


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
