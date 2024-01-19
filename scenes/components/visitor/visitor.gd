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

var bodies :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/bodies/"))
var outfits :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/outfits/"))
var hairs :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/hairs/"))
var eyes :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/eyes/"))


var event_count : int = 0
var room : Room = null
var is_event_active:bool = false

var target_path :Array = []
var direction:Vector2 


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_character()




func _physics_process(_delta):
	animation_tree.set('parameters/Idle/blend_position', direction)
	animation_tree.set('parameters/Walk/blend_position', direction)



func generate_character():
	var body_texture: Image  = load("res://assets/images/character/bodies/"+bodies.pick_random()).get_image() 
	var outfit_texture : Image = load("res://assets/images/character/outfits/"+outfits.pick_random()).get_image() 
	var hair_texture : Image =  load("res://assets/images/character/hairs/"+hairs.pick_random()).get_image() 
	var eyes_texture : Image = load("res://assets/images/character/eyes/"+eyes.pick_random()).get_image()

	character_sprite.texture =  ImageTexture.create_from_image( merge_images([body_texture,outfit_texture,hair_texture,eyes_texture]))
	


func merge_images(images:Array[Image]):

	var result = Image.new()
	result.copy_from(images[0]) # копируем первое изображение

	for i in range(0,images.size()):
		print(images[i].get_width(),images[i].get_height())
		if i==0:continue
		for y in range(images[i].get_height()):
			for x in range(images[i].get_width()):
				var color = images[i].get_pixel(x, y)
				var alpha = color.a
				
				if alpha > 0:
					result.set_pixel(x, y, color)
	return result



func filter_paths(unfiltered_paths:Array)->Array:
	var filtered_paths :Array = []

	for i in range(0,unfiltered_paths.size()):
		if unfiltered_paths[i].rfind(".import")==-1:
			filtered_paths.append(unfiltered_paths[i])
	
	return filtered_paths


func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		generate_character()
