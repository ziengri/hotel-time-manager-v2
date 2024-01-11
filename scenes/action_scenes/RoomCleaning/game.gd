extends Node2D

@onready var hint :Label  =$Label
@onready var progress_bar :ProgressBar = $ProgressBar

@onready var carpet :Sprite2D= $Carpet
@onready var clean_room = $clean_room

var ITEMS_COUNT :int = 13
var items_clear = 0
# Called when the node enters the scene tree for the first time.

func _ready():
	progress_bar.max_value = ITEMS_COUNT
	for i in range(0,ITEMS_COUNT):
		spawn_item()

func spawn_item()->void:
	var trash_scenes : Array = DirAccess.open("res://scenes/action_scenes/RoomCleaning/trash/").get_files()
	
	var trash_new :BaseTrash = load("res://scenes/action_scenes/RoomCleaning/trash/"+trash_scenes.pick_random()).instantiate()
	add_child(trash_new)
	trash_new.item_clear.connect(on_item_clear)
	#var max_y  =  trash_new.sprite.texture.get_height()
	var max_y  = int((carpet.texture.get_height() - trash_new.sprite.texture.get_height()))
	var max_x  = int((carpet.texture.get_width() - trash_new.sprite.texture.get_width()))
	
	var trash_position :Vector2 = Vector2(randi_range(0,max_x),randi_range(0,max_y))
	trash_new.global_position = trash_position

	
	
func on_item_clear()->void:
	items_clear+=1
	progress_bar.value = items_clear
	if(items_clear>= ITEMS_COUNT):
		finish_game()
		

func finish_game():
	hint.text= "Готово"
	await get_tree().create_timer(0.4).timeout
	clean_room.stop()
	get_parent()._finish


func _process(delta):
	pass

		#degress_of_ratation += int(abs(old_degress - full_tank.rotation_degrees))
		#progress_bar.value = degress_of_ratation
		#if degress_of_ratation >= MAX_NEED_ROTATION_DEGRESS:
			#process_mode= Node.PROCESS_MODE_DISABLED
			#get_parent().finish_game()
