extends FSMState


# Executes after the state is entered.
func _on_enter(_actor: Node, _blackboard: Blackboard) -> void:
	var actor = _actor as VisitorCharacter
	actor.animation_state.travel("Idle")
	actor.velocity = Vector2.ZERO
	actor.move_and_slide()
	# print("Вошел в состояние IDLE")


# Executes every _process call, if the state is active.
func _on_update(_delta: float, _actor: Node, _blackboard: Blackboard) -> void:
	var actor = _actor as VisitorCharacter
	




# Executes before the state is exited.
func _on_exit(_actor: Node, _blackboard: Blackboard) -> void:
	pass


# Add custom configuration warnings
# Note: Can be deleted if you don't want to define your own warnings.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	# Add your own warnings to the array here

	return warnings
