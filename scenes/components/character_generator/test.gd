extends Node2D

@onready var animated_sprite :AnimatedSprite2D = $AnimatedSprite2D
#const W_COUNT:int = 57
#const H_COUNT:int = 20

const W_COUNT:int = 4
const H_COUNT:int = 1

const W_SIZE :float = 16 #.2
const H_SIZE :float = 32 #.8


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.frame_changed.connect(func(): print('hello!'))
	animated_sprite.play("default")
	generate_character()


func generate_character():
	var unfiltered_bodies :Array = DirAccess.get_files_at("res://assets/images/character/bodies/")
	var bodies :Array = []

	for i in range(0,unfiltered_bodies.size()):
		if unfiltered_bodies[i].rfind(".import")==-1:
			bodies.append(unfiltered_bodies[i])
	
	var sprite_sheet :Texture  = load("res://assets/images/character/bodies/"+bodies.pick_random())
	var sprite_frames : SpriteFrames = SpriteFrames.new()
	sprite_frames.set_animation_loop("default", true)
	sprite_frames.set_animation_speed("default", 1)
	
	for y in range(0,H_COUNT):
		for x in range(0,W_COUNT):
			var atlas: AtlasTexture = AtlasTexture.new()
			atlas.atlas = sprite_sheet
			atlas.set_region(Rect2(x*W_SIZE, y*H_SIZE, W_SIZE, H_SIZE))   # Define the region of the first sprite
			print(Rect2(x*W_SIZE, y*H_SIZE, W_SIZE, H_SIZE))
			sprite_frames.add_frame("default", atlas,1.0,-1)
	print(sprite_frames.animations)
	animated_sprite.frames = sprite_frames
	animated_sprite.play("default")


func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_accept"):
		generate_character()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#print(	animated_sprite.is_playing())
