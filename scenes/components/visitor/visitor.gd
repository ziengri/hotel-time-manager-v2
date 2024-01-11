extends CharacterBody2D
class_name VisitorCharacter

@export var move_speed : float = 124
@export var visitor_sprite : Texture2D

var direction : Vector2


@onready var sprite: Sprite2D = $Sprite2D
@onready var world: World = get_tree().get_current_scene()
@onready var tile_map: TileMap = get_tree().get_current_scene().get_node("TileMap")
@onready var queue = get_tree().get_current_scene().get_node("Queue")

@onready var states: StateMachineVizitor = $States
@onready var animTree: AnimationTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")
@onready var dissatisfaction: ProgressBar = $Dissatisfaction

#Кол-во эвеннтов
@export var event_count : int = 1
#Закрепленная комната


func _ready():
	sprite.texture = visitor_sprite
	await get_tree().create_timer(1).timeout
	
	states.init(self)
	animTree.active = true


var path: Array

func _physics_process(delta):
	await get_tree().create_timer(1).timeout
	
	states.physics_process(delta)
	
	
	if path == []: 
		animState.travel("Idle")
		return
	
	animate()
	move()


func animate():
	var anim_vector = position.direction_to(  tile_map.map_to_local(path[0])  )
	update_blend_position(anim_vector)
	animState.travel("Move")

func move():
	position = position.move_toward(tile_map.map_to_local(path[0]),1.5)
	
	if position == tile_map.map_to_local(path[0]):
		path.remove_at(0)

func update_blend_position(input_vector):
	animTree.set("parameters/Idle/blend_position",input_vector)
	animTree.set("parameters/Dash/blend_position",input_vector)
	animTree.set("parameters/Move/blend_position",input_vector)
	animTree.set("parameters/Attack/blend_position",input_vector)
	animTree.set("parameters/MoveHold/blend_position",input_vector)
	direction = input_vector



