extends Node

var health = 1
var anim_speed = 1.0
var checkpoint = 0

#MOVEMENT
var last_direction = ""
var base_speed = 30
var position
var speed_modifier = 100.0000
var can_dash = true

#EFFECTS
var effect_list = []

# POWER UPS
var unlock_dash = false
var unlock_shield = false
var unlock_parry = false
var unlock_attack = false
var unlock_shadow_form = false #temp invincibility (upgraded dash)
var unlock_bow = false #arrows on cooldown
