extends Node2D
class_name Weapon

export (PackedScene) var Bullet;

var team: int = -1;

onready var endOfGun = $EndOfGun;
onready var gunDirection = $GunDirection;
onready var attackCooldown = $AttackCooldown;
onready var muzzleFlashAnimation = $AnimationPlayer;

func init(p_team: int):
	team = p_team;
	

func shootBullet():
	if attackCooldown.is_stopped() and Bullet != null:
		var bulletInstance = Bullet.instance();
		var direction = (gunDirection.global_position - endOfGun.global_position).normalized();
		GlobalSignals.emit_signal("bulletFired", bulletInstance, team, endOfGun.global_position, direction);
		attackCooldown.start();
		muzzleFlashAnimation.play("MuzzleFlash");
