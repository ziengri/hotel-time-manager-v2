extends StateMachineVizitor

func init(player) -> void:
	for child in get_children():
		child.player = player
	change_state(BaseStateVisitor.State.QUEUE)

func status_output(current_state):
	$"../Label".text = str(current_state)
