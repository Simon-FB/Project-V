extends Node


var health = 1

#MOVEMENT
var last_direction = ""
var speed = 3000
var position
var dash_bonus = 6000
var dash_canceled = false

	#DASH
var dash_time = 0.5
var dash_cooldown = 1
var dash_OnCooldown = false
var dash_active = false
