class_name LeafWriter extends BTLeaf

@export var target: BTRepeat


func _tick(_delta: float, actor: Node, _blackboard: Blackboard):
	target.repetitions= (actor as VisitorCharacter).event_count
	return BTStatus.SUCCESS
