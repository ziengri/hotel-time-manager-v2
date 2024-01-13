extends CanvasLayer
class_name ActionScene

signal finished
signal canceled
signal failed

@export var physic_stop_reqired = false

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var background : ColorRect =  ColorRect.new()
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.set_color(Color(0,0,0,0.4))
	background.z_index = -1
	background.mouse_filter =Control.MOUSE_FILTER_IGNORE
	add_child(background)
	get_child(0).global_position.x+= 100
	get_child(0).global_position.y+= 50
	
	if physic_stop_reqired : Stats.player.set_physics_process(false)


func _finish()->void:
	if physic_stop_reqired : Stats.player.set_physics_process(true)
	finished.emit()

func _cancel()->void:
	if physic_stop_reqired : Stats.player.set_physics_process(true)
	canceled.emit()


func _fail()->void:
	if physic_stop_reqired:Stats.player.set_physics_process(true)
	failed.emit()


