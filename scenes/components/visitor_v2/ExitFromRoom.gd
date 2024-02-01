extends BTLeaf


func tick(_delta: float, actor: Node, _blackboard: Blackboard):
	(actor as VisitorCharacter).target_path = Rel.world.find_path(actor.global_position,Vector2i(660,80))
	(actor as VisitorCharacter).room.status = Room.RoomStatus.DIRTY
	(actor as VisitorCharacter).room = null
	prints("Путь поставлен",(actor as VisitorCharacter).target_path)
	return BTStatus.SUCCESS
