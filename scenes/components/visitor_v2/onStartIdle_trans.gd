extends FSMTransition


# Executed when the transition is taken.
func _on_transition(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	pass


# Evaluates true, if the transition conditions are met.
func is_valid(_actor: Node, _blackboard: Blackboard) -> bool:
	var actor = _actor as VisitorCharacter
	#print("Моя позиция",Vector2i(actor.global_position))
	#print("target_path",Vector2i(actor.target_path -actor.global_position))

	if actor.target_path == []:
		return true
	if Vector2i(Vector2(actor.target_path[0]) -actor.global_position) == Vector2i.ZERO :
		actor.target_path.remove_at(0)
		return false
	return false



# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
