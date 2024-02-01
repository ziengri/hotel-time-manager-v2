extends Node2D

@onready var character_sprite :Sprite2D = $CharacterSprite2
@onready var animation_tree :AnimationTree = $AnimationTree



var bodies :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/bodies/"))
var outfits :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/outfits/"))
var hairs :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/hairs/"))
# var eyes :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/eyes/"))

const W_SIZE :float = 16 #.2
const H_SIZE :float = 32 #.8



# var x =0 ;
# var y =0 ;

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
	# print("Dist to img")
	# print(Vector2i(x,y))

	var random_body_texture :String ="res://assets/images/character/bodies/"+bodies.pick_random() 
	var random_outfit_texture :String = "res://assets/images/character/outfits/"+outfits.pick_random()
	var random_hair_texture :String = "res://assets/images/character/hairs/"+hairs.pick_random()
	# print("random_body_texture: ",random_body_texture)
	# print("random_outfit_texture: ",random_outfit_texture)
	# print("random_hair_texture: ",random_hair_texture)
	
	var body_texture: Image  = load(random_body_texture).get_image() 
	var outfit_texture : Image = load(random_outfit_texture).get_image() 
	var hair_texture : Image =  load(random_hair_texture).get_image() 



	
	
	character_sprite.texture =  ImageTexture.create_from_image(merge_images([body_texture,outfit_texture,hair_texture])	)
	
	

# func merge_images(images: Array) ->Array:

# 	for i in range(1, images.size()):
# 		if i == 0 : continue
# 		for y in range(images[i].get_height()):
# 			for x in range(images[i].get_width()):
# 				var color = images[i].get_pixel(x, y)
# 				if color.a > 0:
# 					images[0].set_pixel(x , y, color)
		
# 	return images[0]




# func merge_images(img1: Image, img2: Image, offset_x: int, offset_y: int) -> Image:

# 	var width = img1.get_width()
# 	var height = img1.get_height()

# 	var img1_data = img1.get_data()
# 	var img2_data = img2.get_data()

# 	var img2_width = img2.get_width() 
# 	var img2_height = img2.get_height()

# 	# Проходим по координатам изображения
# 	for y in range(height):
# 		for x in range(width):

# 			var idx1 = (y * width + x) * 4 # индекс пикселя в img1

# 			var x2 = x * img2_width / width + offset_x # координата x для img2
# 			var y2 = y * img2_height / height + offset_y # координата y для img2

# 			var idx2 = (y2 * img2_width + x2) * 4 # индекс пикселя в img2

# 			if img2_data[idx2 + 3] > 0:
# 				img1_data[idx1] = img2_data[idx2]
# 				img1_data[idx1+1] = img2_data[idx2+1]  
# 				img1_data[idx1+2] = img2_data[idx2+2]
# 				img1_data[idx1+3] = img2_data[idx2+3]

# 	return Image.create_from_data(width, height, false, Image.FORMAT_RGBA8, img1_data)


func merge_images(images:Array[Image]) -> Image:
	# Размер изображения
	var result :Image = images.pop_front()
	var result_data = result.get_data()

	var width : int = result.get_width()
	var height : int = result.get_height()
		
	for image in images:
		var image_data :PackedByteArray = image.get_data()
		# Проходим по изображениям по пикселям
		for i in range(3,result_data.size(),4):

			if image_data[i] > 0:
				result_data[i-3]=image_data[i-3]
				result_data[i-2]=image_data[i-2]
				result_data[i-1]=image_data[i-1]
				result_data[i]=image_data[i]
	
	# Возвращаем Image from bytes
	return Image.create_from_data(width,height,false,Image.FORMAT_RGBA8,result_data)




func filter_paths(unfiltered_paths:Array)->Array:
	var filtered_paths :Array = []

	for i in range(0,unfiltered_paths.size()):
		if unfiltered_paths[i].rfind(".import")==-1:
			filtered_paths.append(unfiltered_paths[i])
	
	return filtered_paths



func _unhandled_key_input(event):
	if Input.is_action_just_pressed("ui_accept"): generate_character()