extends Node2D

export (PackedScene) var Bullet;

signal weaponFired(bullet, position, direction);

onready var endOfGun = $EndOfGun;
onready var gunDirection = $GunDirection;
onready var attackCooldown = $AttackCooldown;
onready var muzzleFlashAnimation = $AnimationPlayer;

func shootBullet():
	if attackCooldown.is_stopped() and Bullet != null:
		var bulletInstance = Bullet.instance();
		var direction = (gunDirection.global_position - endOfGun.global_position).normalized();
		emit_signal("weaponFired", bulletInstance, endOfGun.global_position, direction);
		attackCooldown.start();
		muzzleFlashAnimation.play("MuzzleFlash");
