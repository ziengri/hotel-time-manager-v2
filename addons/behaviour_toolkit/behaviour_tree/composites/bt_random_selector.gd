@tool
@icon("res://addons/behaviour_toolkit/icons/BTCompositeRandomSelector.svg")
class_name BTRandomSelector extends BTComposite
## The selector composite but with a random order of the leaves.


var is_shuffled: bool = false



func tick(delta: float, actor: Node, blackboard: Blackboard):
	if not is_shuffled:
		leaves.shuffle()
		is_shuffled = true

	
	var response = leaves[0].tick(delta, actor, blackboard)

	if response == BTStatus.SUCCESS or response == BTStatus.FAILURE:
		is_shuffled = false
		return response
	
	return BTStatus.RUNNING
