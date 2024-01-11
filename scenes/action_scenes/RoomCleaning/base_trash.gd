extends Node2D
class_name BaseTrash

signal item_clear

@onready var area : Area2D = $Area2D
@onready var sprite : Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	area.input_event.connect(_on_area_2d_input_event)



func _on_area_2d_input_event(viewport, event:InputEventMouseButton, shape_idx):
	if event.button_index == 1:
		item_clear.emit()
		queue_free()
		
