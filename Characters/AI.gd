extends Node2D

signal stateChanged(newState);

enum State {
	PATROL,
	ENGAGE
};

var moveSpeed = 100;

onready var patrolTimer = $PatrolTimer;

var state: int = -1 setget setState, getState;
var target: KinematicBody2D = null;
var character: KinematicBody2D = null;
var weapon: Weapon = null;
var team: int = -1;

var origin: Vector2 = Vector2.ZERO;
var patrolLocation: Vector2 = Vector2.ZERO;
var patrolReached: bool = false;
var characterVelocity: Vector2 = Vector2();

func _ready():
	setState(State.PATROL);

func _physics_process(delta):
	match state:
		State.PATROL:
			if not patrolReached:
				character.move_and_slide(characterVelocity);
				character.rotateTowards(patrolLocation);
				if character.global_position.distance_to(patrolLocation) < 5:
					patrolReached = true;
					characterVelocity = Vector2();
					patrolTimer.start();
		State.ENGAGE:
			if target != null && weapon != null:
				character.rotateTowards(target.global_position);
				var angleToTarget = character.global_position.direction_to(target.global_position).angle();
				if abs(character.rotation - angleToTarget) < 0.05:
					weapon.shootBullet();
			else:
				print("ERROR! Target or Weapon is undefined in AI.")
		_:
			print("ERROR! Non-existant state value.")

func init(p_character, p_weapon: Weapon, p_team: int):
	character = p_character;
	weapon = p_weapon;
	team = p_team;

func setState(newState: int):
	if state == newState:
		return
	
	if newState == State.PATROL:
		origin = global_position;
		patrolReached = true;
		patrolTimer.start();
	
	state = newState;
	emit_signal("stateChanged", state);

func getState():
	return state;

func _on_DetectionZone_body_entered(body):
	if body.has_method("getTeam") and body.getTeam() != team:
		setState(State.ENGAGE);
		target = body;

func _on_DetectionZone_body_exited(body):
	if target and body == target:
		setState(State.PATROL);
		target = null;

func _on_PatrolTimer_timeout():
	var patrolRange = 300;
	var patrolRandX = rand_range(-patrolRange, patrolRange);
	var patrolRandY = rand_range(-patrolRange, patrolRange);
	patrolLocation = Vector2(patrolRandX, patrolRandY) + origin;
	patrolReached = false;
	characterVelocity = character.velocityTowards(patrolLocation);
