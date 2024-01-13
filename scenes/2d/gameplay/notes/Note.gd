@tool
## self explantory RIGHT?
class_name Note extends Node2D
## cool note data
var data:NoteData
## strum is set on spawn of note
var strum:StrumLine
var override_position:Vector2 = Vector2.INF

var step:float = 0:
	get:
		return data.hit_time / Conductor.step_crochet
var can_hit:bool:
	get:
		return absf(data.hit_time - Conductor.time) <= 0.180
var too_late:bool:
	get:
		return Conductor.time - (data.hit_time + data.sustain_length) > 0.180
## the thing displayed
@onready var sprite = $sprite
## soup-port for RGB SHADER
@export var support_custom_color:bool = false
	#set(v):
		#support_custom_color = v
		#if not sprite: return
		#if support_custom_color and sprite.material == null:
			#sprite.material = ShaderMaterial.new()
			#sprite.material.shader = preload("res://scenes/2d/gameplay/note shader.gdshader")
		#sprite.material.set_shader_parameter("enable",support_custom_color)
