extends Node

var map_width : int = 10
var map_height : int = 10
var map : Array = []

var num_treasure_rooms : int = 5
var num_normal_rooms : int = 20

func _ready():
    generate_map()

func generate_map():
    # Initialize the map
    map.resize(map_width)
    for x in range(map_width):
        map[x] = []
        map[x].resize(map_height)
        for y in range(map_height):
            map[x][y] = null

    # Generate start and end rooms
    map[0][0] = Room(RoomType.START, Vector2(0, 0))
    map[map_width - 1][map_height - 1] = Room(RoomType.END, Vector2(map_width - 1, map_height - 1))

    # Generate treasure rooms
    generate_rooms(RoomType.TREASURE, num_treasure_rooms)

    # Generate normal rooms
    generate_rooms(RoomType.NORMAL, num_normal_rooms)

func generate_rooms(room_type, num_rooms):
    for i in range(num_rooms):
        var x = randi() % map_width
        var y = randi() % map_height

        # Check if the room is already occupied
        if map[x][y] == null:
            map[x][y] = Room(room_type, Vector2(x, y))
        else:
            # If the position is occupied, try again
            i -= 1