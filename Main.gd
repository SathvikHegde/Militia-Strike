extends Node2D

onready var bulletManager = $BulletManager;
onready var player: Player = $Player;

func _ready():
	randomize();
	GlobalSignals.connect("bulletFired", bulletManager, "handleBulletSpawned");
