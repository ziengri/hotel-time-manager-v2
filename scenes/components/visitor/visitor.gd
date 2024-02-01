extends CharacterBody2D
class_name VisitorCharacter
# 640360
# 1280720
const W_SIZE :float = 16 #.2
const H_SIZE :float = 32 #.8

@export var move_speed : float = 50
@export var MAX_SPEED : float = 50
@export var state_machine: FiniteStateMachine
@export var behaviour_tree: BTRoot

@onready var character_sprite :Sprite2D = $CharacterSprite
@onready var animation_tree :AnimationTree = $AnimationTree
@onready var animation_state : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

var event_count : int = 0
var room : Room = null
var is_event_active:bool = false

var target_path :Array = []
var direction:Vector2 

func _ready():
	state_machine.start()





func _physics_process(_delta):
	animation_tree.set('parameters/Idle/blend_position', direction)
	animation_tree.set('parameters/Move/blend_position', direction)



