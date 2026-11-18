@tool
class_name CellDrawerTerrain
extends    CellDrawerOnTilemap

@export var terrain_set : int
@export var terrain     : int

func draw_cells_arr(
			drawer          : MapDisplayer, 
			cell_parameters : CellDisplayParameters,
			type            : CellsDrawer.CELL_TYPE,
			cells           : Array[Vector2i],
		) -> void:
	var layer : TileMapLayer = drawer.GetLayerByType(type)
	if  layer != null:
		layer.set_cells_terrain_connect(cells, terrain_set, terrain)
	pass
