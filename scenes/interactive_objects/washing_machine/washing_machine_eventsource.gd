extends EventSource


# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.event_sources[event_key] =  self


