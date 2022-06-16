extends KinematicBody2D

export (int) var speed = 100;

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

func rotateTowards(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1);

func velocityTowards(location: Vector2):
	return global_position.direction_to(location) * speed;
