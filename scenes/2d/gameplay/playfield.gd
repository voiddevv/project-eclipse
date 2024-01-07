extends Node2D

var chart:Chart = Chart.new()
var bpm_index:int = 0
# for every zoom_beat the hud zooms
var zoom_beat:int = 4
# how much to scale the zoom per zoom_beat
var zoom_amount:Vector2 = Vector2(0.03, 0.03)
@onready var strums:Node2D = $"HUD Layer/HUD/strums"
@onready var tracks:Node = $tracks
@onready var hud_layer:CanvasLayer = $"HUD Layer"
@onready var hud:Control = $"HUD Layer/HUD"


# Called when the node enters the scene tree for the first time.
func _ready():
	Conductor.bar_hit.connect(bar_hit)
	Conductor.beat_hit.connect(beat_hit)
	chart = Chart.load_chart("bopeebo","hard.json")
	Conductor.bpm = chart.initial_bpm
	load_tracks()
func load_tracks():
	var song_path:String = "res://songs/%s/tracks/" %chart.song_name.to_lower()
	
	var files:PackedStringArray = DirAccess.get_files_at(song_path)
	for file in files:
		if file.ends_with(".import"):
			print(file.replace(".import",""))
			var stream:AudioStream = load(song_path + file.replace(".import",""))
			var player:AudioStreamPlayer = AudioStreamPlayer.new()
			player.stream = stream
			tracks.add_child(player)
	
	for player in tracks.get_children():
		player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Conductor.time += delta
	
func check_bpm_chnage():
	for k in chart.bpms.keys():
		if chart.bpms.keys().find(k) < bpm_index: continue
		if Conductor.time >= k:
			bpm_index += 1
			Conductor.bpm = chart.bpms.get(k)

func _physics_process(delta):
	check_bpm_chnage()
	hud.scale = lerp(hud.scale,Vector2.ONE,delta*5.0)
func bar_hit(bar:int):
	pass
func beat_hit(beat:int):
	if beat %zoom_beat == 0:
		hud.scale += zoom_amount
	pass
