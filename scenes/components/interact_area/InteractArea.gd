extends Area2D
class_name InteractArea
var entered :bool = false

signal interacted

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		if Input.is_action_just_released("interact"):
			interacted.emit()


func _on_area_entered(area):
	print("enter")
	entered = true


func _on_area_exited(area):
	print("exit")
	entered = false
