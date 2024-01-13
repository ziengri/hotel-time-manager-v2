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
	
	var trash_new :BaseTrash = load("res://scenes/action_scenes/RoomCleaning/trash/"+trash_scenes.pick_random().trim_suffix(".remap")).instantiate()
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
	await get_tree().create_timer(0.3).timeout
	var room_number :int = int(((get_parent().get_parent() as EventSource).event_key).split("_")[2])
	for room in get_tree().get_nodes_in_group("rooms"):
		print((room as Room).room_number)
		print(room_number)	
		if (room as Room).room_number == room_number:
	
			(room as Room).status = Room.RoomStatus.FREE
	clean_room.stop()
	get_parent()._finish()


func _process(delta):
	pass

		#degress_of_ratation += int(abs(old_degress - full_tank.rotation_degrees))
		#progress_bar.value = degress_of_ratation
		#if degress_of_ratation >= MAX_NEED_ROTATION_DEGRESS:
			#process_mode= Node.PROCESS_MODE_DISABLED
			#get_parent().finish_game()
