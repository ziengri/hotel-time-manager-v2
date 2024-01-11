extends CharacterBody2D


@export var move_speed : float = 124


var direction : Vector2

@onready var use_area :Area2D = $Area2D

@onready var states: StateMachine = $States
@onready var animTree: AnimationTree = $AnimationTree
@onready var animState = animTree.get("parameters/playback")
@onready var tile_map: TileMap = get_tree().get_current_scene().get_node("TileMap")

enum ObjectHold{
	NONE,
	FOOD,
	DIRTY,
	CLEAN
}

var object_in_hands: ObjectHold = ObjectHold.NONE: set = anim

func anim(anim):
	$Sprite2D.texture = load("res://assets/images/player/Character_sprite_"+str(anim)+".png")
	object_in_hands = anim

func _ready():
	states.init(self)
	animTree.active = true

@onready var area_2d :Area2D = $Area2D

func _unhandled_input(event):
	states.input(event)
	if Input.is_action_just_pressed("ui_select"):
		var areas_2d : Array[Area2D] = area_2d.get_overlapping_areas()
		if areas_2d.size() <= 0: return
		var event_source : EventSource = areas_2d[0] as EventSource
		event_source.interact()
		#object_in_hands = ObjectHold.CLEAN
		#var p = tile_map.local_to_map(position)
		#print(tile_map.get_cell_source_id(0,p))


func _physics_process(delta):
	states.physics_process(delta)

func update_blend_position(input_vector):
	animTree.set("parameters/Idle/blend_position",input_vector)
	animTree.set("parameters/Dash/blend_position",input_vector)
	animTree.set("parameters/Move/blend_position",input_vector)
	animTree.set("parameters/Attack/blend_position",input_vector)
	animTree.set("parameters/MoveHold/blend_position",input_vector)
	direction = input_vector





