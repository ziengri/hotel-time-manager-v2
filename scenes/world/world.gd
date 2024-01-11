extends Node2D
class_name World

@onready var tile_map: TileMap = $TileMap
@onready var AStarGrid: AStarGrid2D = AStarGrid2D.new()
@onready var queue = $Queue


func _ready():
	Stats.stars = 5
	Stats.player = $CharacterBody2D
	init_AstarGrid()


func find_path(_start_cell: Vector2i, _end_cell: Vector2i) -> Array[Vector2i]:
	var path: Array[Vector2i] = AStarGrid.get_id_path( _start_cell, _end_cell)
	return path

func init_AstarGrid() -> void:
	AStarGrid.size = Vector2i(100,100)
	AStarGrid.region = Rect2i(-1, -1, 100, 100)
	AStarGrid.cell_size = Vector2i(16,16)
	AStarGrid.update()
	
	AStarGrid.default_estimate_heuristic = 1
	AStarGrid.diagonal_mode = 1
	
	var cells = tile_map.get_used_cells(1)
	cells.sort()
	
	for cell_id in range(cells.size()):
		var cell = cells[cell_id]
		if tile_map.get_cell_source_id(1,cell) != -1:
			AStarGrid.set_point_solid(cell, true)
