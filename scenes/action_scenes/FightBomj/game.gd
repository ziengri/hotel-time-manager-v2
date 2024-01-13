extends Node2D

@onready var area_2d: Area2D = $Sprite2D/Area2D
@onready var progress_bar: ProgressBar = $Container/ProgressBar
@onready var fight_sound = $fight_sound

@onready var label = $Container/Label
var hp: int = 50
#var text: Array["Отлично!",""]

func _ready():
	area_2d.input_event.connect(hit)
	progress_bar.max_value = hp
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func hit(viewport, event:InputEventMouseButton, shape_idx):
	$Container/ProgressBar.show()
	if label.text == "Готово": return
	
	if event.button_index == 1:
		if hp%2 == 0:
			$Sprite2D.scale = Vector2(0.8,0.8)
		else: $Sprite2D.scale = Vector2(1,1)
		
		hp -= 1
		progress_bar.value += 1
		
		if progress_bar.value == progress_bar.max_value:
			finish_game()

func _process(delta):
	$Sprite2D2.position = get_local_mouse_position()
	$Sprite2D2.position.x = clamp($Sprite2D2.position.x,0,450)
	$Sprite2D2.position.y = clamp($Sprite2D2.position.y,0,250)



func finish_game():
	label.text= "Готово"
	await get_tree().create_timer(1).timeout
	fight_sound.stop()
	$Sprite2D.hide()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_parent()._finish()
