extends Node

enum RoomType { EMPTY, START, END, NORMAL, TREASURE }

class_name Room

class Room:
    var type : RoomType
    var position : Vector2

    func _init(type, position):
        self.type = type
        self.position = position

class_name MapGenerator