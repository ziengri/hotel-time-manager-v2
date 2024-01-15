extends Node2D
class_name World

@onready var nav_map: TileMap = $NavMap
@onready var AStarGrid: AStarGrid2D = AStarGrid2D.new()
@onready var queue = $Queue



func _init():
	Rel.world = self

func _ready():
	Stats.stars = 5
	Stats.player = $CharacterBody2D
	init_AstarGrid()

#Ищет ближайщий путь от точки до точки по Навигацционной карте 
func find_path(source_global_position: Vector2, target_global_position: Vector2,filtering:bool = true) -> Array:
	var path: Array = AStarGrid.get_id_path( nav_map.local_to_map(source_global_position),nav_map.local_to_map(target_global_position) )
	var global_paths = []
	for p in path:
		global_paths.append(nav_map.map_to_local(p))
	return global_paths



func init_AstarGrid() -> void:
	AStarGrid.region = nav_map.get_used_rect()

	AStarGrid.cell_size = Vector2(8,8)
	AStarGrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	AStarGrid.default_estimate_heuristic = 1
	AStarGrid.jumping_enabled = true
	AStarGrid.update()
	print(AStarGrid.region)

	var region_size = AStarGrid.region.size
	var region_position = AStarGrid.region.position
	
	#FIXME Возомжно(скорее всего) есть более лучший способ заполнить AStarGrid
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(
				x+ region_position.x,
				y+ region_position.y
			)
			#Заполняет только там где нету тайла на nav map
			if nav_map.get_cell_source_id(0,tile_position) == -1:
				AStarGrid.set_point_solid(tile_position, true)
	

	#var player_paths :Array =find_path(Stats.player.global_position,Vector2(802,717))
	#var path_debug :Line2D = Line2D.new()
	#path_debug.width = 3
	#path_debug.default_color = Color.RED
	#for point in player_paths:
		#path_debug.add_point(nav_map.map_to_local(point))
	#add_child(path_debug)
#
	#for path in player_paths:
		#await get_tree().create_timer(1).timeout
		#Stats.player.global_position = nav_map.map_to_local(path)
	


