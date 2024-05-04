class_name spawner
extends Node2D
var minX: int = -2000
var maxX: int = 2000
var minY: int = -700
var maxY: int = 1000
var entityScene: PackedScene
var playerScene: PackedScene
var player:CharacterBody2D
var random = RandomNumberGenerator.new()
var entityRadius: int
var spawnPositions: Array = []

func _ready():
    playerScene = load("res://Scenes/Player/player.tscn")
    player = playerScene.instantiate()

func set_entity(entity_scene: PackedScene, entity_radius: int):
    entityScene = entity_scene
    entityRadius = entity_radius

func spawn_entities(num_entities: int, colors: Array =[], sprite: String =""):
    spawnPositions.clear()
    for i in range(num_entities):
        var randomPos
        var randomScale
        var posValid = false
        while not posValid:
            var randomX = randf_range(minX, maxX)
            var randomY = randf_range(minY, maxY)
            randomPos = Vector2(randomX, randomY)
            randomScale = randf_range(1, 1.5)
            var effectiveRadius = entityRadius * randomScale
            posValid = is_valid_entity(randomPos, effectiveRadius) && !is_player_close(randomPos)
        spawnPositions.append(randomPos)
        var entityInstance = entityScene.instantiate()
        entityInstance.position = randomPos
        entityInstance.scale = Vector2(randomScale, randomScale)
        if sprite != "":
            var entitySprite = entityInstance.get_node(sprite)
            entitySprite.modulate = Color(1, 1, 1, 1)
            var colorIndex = randi() % colors.size()
            entitySprite.modulate *= colors[colorIndex]
        add_child(entityInstance)

func is_valid_entity(new_pos, effective_radius: int):
    for child in get_children():
        if child is Node2D and new_pos.distance_to(child.position) < effective_radius:
            return false
    return true

func is_player_close(new_pos: Vector2):
    if player != null and player.position != null:
        if manhattan_distance(player.position, new_pos) < entityRadius * 5:
            return true
    return false

func manhattan_distance(pointA: Vector2, pointB: Vector2):
    var deltaX = abs(pointA.x - pointB.x)
    var deltaY = abs(pointA.y - pointB.y)
    return deltaX + deltaY

