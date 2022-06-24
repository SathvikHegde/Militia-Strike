extends Node2D

enum TeamName {
	Player,
	Enemy
}

export (TeamName) var team = TeamName.Player;
