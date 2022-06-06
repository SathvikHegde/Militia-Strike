extends Node2D

onready var bulletManager = $BulletManager;
onready var player: Player = $Player;

func _ready():
	GlobalSignals.connect("bulletFired", bulletManager, "handleBulletSpawned");

func _process(delta):
	pass
