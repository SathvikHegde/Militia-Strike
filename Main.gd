extends Node2D

onready var bulletManager = $BulletManager;
onready var player: Player = $Player;

func _ready():
	player.connect("playerFiredBullet", bulletManager, "handleBulletSpawned");

func _process(delta):
	pass
