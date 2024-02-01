extends Marker2D
class_name Spawner

@export var visitors_count : int  = 1
@onready var timer :Timer = $Timer
@export var visitor_scene :PackedScene

var thread = Thread.new()

var bodies :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/bodies/"))
var outfits :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/outfits/"))
var hairs :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/hairs/"))
# var eyes :Array = filter_paths(DirAccess.get_files_at("res://assets/images/character/eyes/"))

# Called when the node enters the scene tree for the first time.
func _ready()->void:
	
	#print(DirAccess.open(visitors_sprite_path).get_files())


	timer.timeout.connect(spawn_visitor)
	#timer.wait_time = 10
	timer.wait_time = randi_range(1,3)
	timer.start()
	
func spawn_visitor()->void:
	if(visitors_count>0):
		print("SPAWN VISITOR")
		var visitor : VisitorCharacter = visitor_scene.instantiate() as VisitorCharacter
		var visitor_texture = await generate_character()
		#print_debug("СДЕЛАЙ НОРМАЛЬНЫЙ РАНДОМ")
		#visitor.visitor_sprite = load(visitors_sprite_path+(texture_array.pick_random()).trim_suffix(".import"))
		visitor.event_count = randi_range(1,2)
		visitor.global_position = global_position
		visitors_count -=1
		Rel.world.add_child(visitor)
		visitor.character_sprite.texture = 	visitor_texture

	

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

	var merged_texture =ImageTexture.create_from_image( merge_images([body_texture,outfit_texture,hair_texture])	)

	return merged_texture


func merge_images(images:Array[Image]) -> Image:
	# Размер изображения

	var width = images[0].get_width()
	var height = images[0].get_height()
	for i in images.size():
		if i == 0:continue
		images[0].blend_rect(images[i],Rect2(Vector2.ZERO,Vector2(width,height)),Vector2i.ZERO)
	return images[0]

	

func filter_paths(unfiltered_paths:Array)->Array:
	var filtered_paths :Array = []

	for i in range(0,unfiltered_paths.size()):
		if unfiltered_paths[i].rfind(".import")==-1:
			filtered_paths.append(unfiltered_paths[i])
	
	return filtered_paths