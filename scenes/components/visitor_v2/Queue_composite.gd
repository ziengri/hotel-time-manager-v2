extends BTSequence

var queue_number = null

func _ready():
	for leaf in leaves:
		if not (leaf is LeafPrint):
			leaf.queue_composite = self
