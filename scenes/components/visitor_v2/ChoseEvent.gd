extends BTRandomSelector





func tick(delta: float, actor: Node, blackboard: Blackboard):
	if not is_shuffled:
		leaves.shuffle()

	if current_leaf > leaves.size() -1:
		current_leaf = 0
		is_shuffled = false
		return BTStatus.FAILURE
	
	var response = leaves[current_leaf].tick(delta, actor, blackboard)

	if response == BTStatus.SUCCESS:
		current_leaf = 0
		is_shuffled = false
		return response
	
	if response == BTStatus.RUNNING:
		return response

	if response == BTStatus.FAILURE:
		return response
	
	current_leaf += 1
	return BTStatus.RUNNING
