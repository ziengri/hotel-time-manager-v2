extends Node2D

@onready var white_noise = $AnimatedSprite2D
@onready var television_button = $TelevisionButton
@onready var broken_tv: AudioStreamPlayer = $broken_tv
@onready var football: AudioStreamPlayer = $football


var need_rotation_degress :int
var inaccuracy_degress : int = 100
@onready var timer :Timer = $Timer


var timer_started : bool = false

func _ready():
	white_noise.play("default")
	white_noise.modulate = Color(1,1,1,1)
	point = randi_range(-4,1.2)
	range = point + range
	timer.timeout.connect(check)

	
	
var wait: bool = false
var point: float
var range: float = 0.2

func _process(delta):
	var btn_degress = 0
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		television_button.look_at(get_viewport().get_mouse_position())
		btn_degress = television_button.rotation
	#print(television_button.rotation)
	
	television_button.rotation = clamp(television_button.rotation,-4.45,1.3)
	
	if television_button.rotation >= point and television_button.rotation <= range:
		white_noise.modulate.a = lerp(white_noise.modulate.a ,0.0, 000.1)
		
		#football.set_volume_db(lerp(football.volume_db,-10.0, 0.1))
		broken_tv.set_volume_db(lerp(broken_tv.volume_db,-500.0, 0.1))
	else:
		white_noise.modulate.a = lerp(white_noise.modulate.a ,1.0, 0.1)
		
		broken_tv.set_volume_db(lerp(broken_tv.volume_db,-10.0, 0.1))
		#football.set_volume_db(lerp(football.volume_db,-15.0, 0.1))
		
	
	if television_button.rotation >= point and television_button.rotation <= range and wait == false:
		timer.start(1)
		wait = true


func check():
	wait = false
	if television_button.rotation >= point and television_button.rotation <= range:
		if white_noise.modulate.a < 0.05 != true:
			return
		set_process(false)
		$Container/Label.text= "Готово"
		await get_tree().create_timer(1).timeout
		get_parent()._finish()
		wait = false
