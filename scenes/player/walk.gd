extends BaseState

func enter()->void:
	player.animState.travel("Move")

 



func physics_procces(delta: float)->int:
	var input_vector = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if input_vector == Vector2.ZERO: return State.IDLE
	
	#print(input_vector)
	#Обновление параметров анимации
	player.update_blend_position(input_vector) 
	
	#Передвижение
	player.velocity = input_vector*player.move_speed
	player.move_and_slide()
	
	
	return State.NULL

	




