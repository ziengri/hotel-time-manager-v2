extends Node2D

@onready var timer: Timer = $Timer
@onready var label = $Container/Label
@onready var pan = $Pan
@onready var fire = $Marker2D.position

var progress_point = 36
@onready var area_2d_1 = $Sprite2D/Area2D
@onready var chicken = $Pan/Chicken
@onready var progress_bar: ProgressBar = $Container/ProgressBar
@onready var coocing: bool = false
@onready var cooking_sound = $cooking_sound


func _ready():
	area_2d_1.input_event.connect(on_fire)
	timer.timeout.connect(random)
	progress_bar.max_value = 10000

func on_fire(viewport, event:InputEventMouseButton, shape_idx):
	label.text = "Используй A/D что бы \nне дать сбежать курочке с плиты"
	area_2d_1.input_event.disconnect(on_fire)
	$Sprite2D.texture = load("res://scenes/action_scenes/cooking_food/resourses/kitchen_stove_on.png")
	pan.position.x = fire.x
	chicken.show()
	progress_bar.show()
	timer.start(0.2)
	coocing = true



func random():
	if randi_range(0,1) == 1:
		random_move = randi_range(1,2.5)
	else:
		random_move = randi_range(-1,-2.5)
	
	timer.start(randi_range(0,2))


var random_move: float = 0
func _physics_process(delta):
	pan.position.x = clamp(pan.position.x,0,450)
	
	if not coocing: return
	
	pan.position.x += random_move
	
	if Input.is_action_pressed("move_left"):
		pan.position.x += 3
	if Input.is_action_pressed("move_right"):
		pan.position.x -= 3
	
	if ( progress_point - pan.position.distance_to(fire) ) >= 0:
		chicken.position.y = randi_range(-1,3)
	
	
	

	
	print(progress_bar.value,"   ", pan.position.distance_to(fire))

func _process(delta):
	if not coocing: return
	
	if ( progress_point - pan.position.distance_to(fire) ) >= 0:
		progress_bar.value += progress_point - pan.position.distance_to(fire)
		
		if progress_bar.value >= progress_bar.max_value: 
			finish_game()


func finish_game():
	label.text= "Готово"
	coocing = false
	$Sprite2D.texture = load("res://scenes/action_scenes/cooking_food/resourses/kitchen_stove_off.png")
	await get_tree().create_timer(1).timeout
	cooking_sound.stop()
	get_parent()._finish()
