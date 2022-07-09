extends Node2D

func handleBulletSpawned(bullet: Bullet, team: int, position: Vector2, direction: Vector2):
	add_child(bullet);
	bullet.team = team;
	bullet.global_position = position;
	bullet.setDirection(direction);
