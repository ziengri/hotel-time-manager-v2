extends Node2D

@onready var character_sprite :Sprite2D = $CharacterSprite2
@onready var animation_tree :AnimationTree = $AnimationTree



var bodies :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/bodies/"))
var outfits :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/outfits/"))
var hairs :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/hairs/"))
var eyes :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/eyes/"))

const W_SIZE :float = 16 #.2
const H_SIZE :float = 32 #.8



var x =0 ;
var y =0 ;

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
	print("Dist to img")
	print(Vector2i(x,y))

	var random_body_texture :String ="res://assets/images/character/bodies/"+bodies.pick_random() 
	var random_outfit_texture :String = "res://assets/images/character/outfits/"+outfits.pick_random()
	var random_hair_texture :String = "res://assets/images/character/hairs/"+hairs.pick_random()
	var random_eyes_texture :String = "res://assets/images/character/eyes/"+eyes.pick_random()
	print("random_body_texture: ",random_body_texture)
	print("random_outfit_texture: ",random_outfit_texture)
	print("random_hair_texture: ",random_hair_texture)
	print("random_eyes_texture: ",random_eyes_texture)
	
	var body_texture: Image  = load(random_body_texture).get_image() 

	FileAccess.open("res://test.dat",FileAccess.WRITE).store_buffer(body_texture.get_data())
	var outfit_texture : Image = load(random_outfit_texture).get_image() 
	var hair_texture : Image =  load(random_hair_texture).get_image() 
	var eyes_texture : Image = load(random_eyes_texture).get_image()

	character_sprite.texture =  ImageTexture.create_from_image( merge_images([body_texture,hair_texture]))
	


func merge_images(images:Array[Image]):

	# var result = Image.new()
	# result.copy_from(images[0]) # копируем первое изображение

	for i in range(0,images.size()):
		print(images[i].get_width(),images[i].get_height())
		if i==0:continue
		for y in range(images[i].get_height()):
			for x in range(images[i].get_width()):
				var color = images[i].get_pixel(x, y)
				var alpha = color.a
				
				if alpha > 0:
					images[0].set_pixel(x, y, color)
	return images[0]
	# for i in range(0,images.size()):
	# # print(images[i].get_width(),images[i].get_height())
	# 	if i==0:continue
	# 	images[0].blend_rect(images[i],images[i].get_used_rect(),Vector2i(x,y))

	# return images[0]



func filter_paths(unfiltered_paths:Array)->Array:
	var filtered_paths :Array = []

	for i in range(0,unfiltered_paths.size()):
		if unfiltered_paths[i].rfind(".import")==-1:
			filtered_paths.append(unfiltered_paths[i])
	
	return filtered_paths


func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_up"):
		y -=1
		generate_character()
	if Input.is_action_just_pressed("ui_down"):
		y +=1
		generate_character()
	if Input.is_action_just_pressed("ui_left"):
		x -=1
		generate_character()
	if Input.is_action_just_pressed("ui_right"):	
		x +=1			
		generate_character()	
	if Input.is_action_just_pressed("ui_accept"):
		generate_character()
