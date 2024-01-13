extends Node2D

var target : Node2D
var event
@onready var sprite_2d :Sprite2D = $Sprite2D
@onready var player_camera :Camera2D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
# Получаем ссылку на объект Camera2D
	var this_target = target
	if (event['event_info'] as EventInfo).event_key == "need_food":
		if Stats.player.object_in_hands != Stats.player.ObjectHold.FOOD:
			this_target = get_tree().get_nodes_in_group("world")[0].get_node("Furnace")
	if (event['event_info'] as EventInfo).event_key == "wardrobe":
		if Stats.player.object_in_hands == Stats.player.ObjectHold.DIRTY:
			this_target = get_tree().get_nodes_in_group("world")[0].get_node("WashingMachine")
	# Получаем размер экрана
	var screen_size = get_viewport_rect().size

	# Получаем позицию верхнего левого угла в мировых координатах
	var top_left = player_camera.global_position - (screen_size / 2) / player_camera.zoom
	top_left.x += 50
	top_left.y += 50

	# Получаем позицию правого нижнего угла в мировых координатах
	var bottom_right = player_camera.global_position + (screen_size / 2) / player_camera.zoom
	bottom_right.x -= 50
	bottom_right.y -= 50

	# Получаем направление к целевому объекту
	var direction = (this_target.global_position - sprite_2d.global_position).normalized()

	# Устанавливаем новую позицию стрелочки, используя линейную интерполяцию
	sprite_2d.global_position = sprite_2d.global_position.lerp(this_target.global_position, 0.1)

	# Корректируем позицию стрелочки, чтобы она оставалась в пределах экрана
	sprite_2d.global_position.x = clamp(sprite_2d.global_position.x, top_left.x, bottom_right.x)
	sprite_2d.global_position.y = clamp(sprite_2d.global_position.y, top_left.y, bottom_right.y)

	# Поворачиваем стрелочку, чтобы она смотрела в направлении целевого объекта
	look_at(this_target.global_position)
