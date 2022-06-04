extends KinematicBody2D

var health: int = 100;

func handleHit():
	health -= 30;
	if health <= 0:
		queue_free();
		print("Enemy Destroyed");
	else:
		print("Enemy got hit. Health: ", health);
