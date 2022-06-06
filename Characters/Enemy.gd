extends KinematicBody2D

onready var health = $Health;
onready var ai = $AI;
onready var weapon = $Weapon;

func _ready():
	ai.init(self, weapon);

func handleHit():
	health.health -= 30;
	if health.health <= 0:
		queue_free();
		print("Enemy Destroyed");
	else:
		print("Enemy got hit. Health: ", health.health);
