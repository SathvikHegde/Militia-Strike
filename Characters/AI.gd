extends Node2D

signal stateChanged(newState);

enum State {
	PATROL,
	ENGAGE
};

onready var detectionZone = $DetectionZone;
onready var patrolTimer = $PatrolTimer;

var state: int = State.PATROL setget setState, getState;
var player: Player = null;
var character = null;
var weapon: Weapon = null;

var origin: Vector2 = Vector2();
var patrolLocation: Vector2 = Vector2();
var patrolReached: bool = false;

func _process(delta):
	match state:
		State.PATROL:
			if not patrolReached:
				pass
		State.ENGAGE:
			if player != null && weapon != null:
				var angleToPlayer = character.global_position.direction_to(player.global_position).angle();
				character.rotation = lerp(character.rotation, angleToPlayer, 0.1);
				if abs(character.rotation - angleToPlayer) < 0.05:
					weapon.shootBullet();
			else:
				print("ERROR! Player or Weapon is undefined in AI.")
		_:
			print("ERROR! Non-existant state value.")

func init(p_character, p_weapon: Weapon):
	character = p_character;
	weapon = p_weapon;

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
	if body.is_in_group("Player"):
		setState(State.ENGAGE);
		player = body;

func _on_DetectionZone_body_exited(body):
	if player and body == player:
		setState(State.PATROL);
		player = null;

func _on_PatrolTimer_timeout():
	var patrolRange = 13;
	var patrolRandX = rand_range(-patrolRange, patrolRange);
	var patrolRandY = rand_range(-patrolRange, patrolRange);
	patrolLocation = Vector2(patrolRandX, patrolRandY) + origin;
	patrolReached = false;
	
