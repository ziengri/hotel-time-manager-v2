extends StateMachine

func status_output(current_state):
	$"../Label".text = str(current_state)
