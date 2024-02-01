extends BTSequence




func tick(delta: float, actor: Node, blackboard: Blackboard):
	if current_leaf > leaves.size() -1:
		current_leaf = 0
		return BTStatus.SUCCESS
	

	var response = leaves[current_leaf].tick(delta, actor, blackboard)
	if response == BTStatus.RUNNING:
		return response
	
	if response == BTStatus.FAILURE:
		current_leaf = 0
		return response
	
	
	current_leaf += 1
	return BTStatus.RUNNING	
