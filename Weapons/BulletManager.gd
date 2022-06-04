extends Node2D

func handleBulletSpawned(bullet: Bullet, position: Vector2, direction: Vector2):
	add_child(bullet);
	bullet.global_position = position;
	bullet.setDirection(direction);
