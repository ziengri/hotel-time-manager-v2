extends Node2D

@onready var full_tank : Sprite2D = $FullTank
@export var MAX_NEED_ROTATION_DEGRESS = 10000
@export var degress_of_ratation = 0
var progress_bar :ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode= Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var old_degress = full_tank.rotation_degrees
		full_tank.look_at(get_viewport().get_mouse_position())
		degress_of_ratation += int(abs(old_degress - full_tank.rotation_degrees))
		progress_bar.value = degress_of_ratation
		if degress_of_ratation >= MAX_NEED_ROTATION_DEGRESS:
			process_mode= Node.PROCESS_MODE_DISABLED
			get_parent().finish_game()
