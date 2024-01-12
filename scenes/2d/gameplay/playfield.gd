extends Node2D

static var chart:Chart = Chart.new()
var bpm_index:int = 0
var note_index:int = 0
@onready var template_notes:Dictionary = {
	"Default" : preload("res://scenes/2d/gameplay/notes/Default.tscn").instantiate(),
}
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
	chart = Chart.load_chart("crystallized","hard.json")
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
	for i:AudioStreamPlayer in tracks.get_children():
		var _t:float = i.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
		if _t - Conductor.time >= 0.015:
			Conductor.time = _t
			i.seek(_t)
	call_deferred(&"spawn_notes")
func bar_hit(bar:int):
	pass
	
func spawn_notes():
	for i in chart.notes.size():
		if i < note_index: continue
		
		var _note:Note = template_notes["Default"].duplicate() as Note
		_note.data = chart.notes[i]
		if _note.data.hit_time - Conductor.time >= 1.5: break
		var note_strum_id:int = _note.data.strum_id
		var strum_count:int = strums.get_child_count()
		_note.strum = strums.get_child(note_strum_id%strum_count)
		_note.strum.note_group.add_child(_note)
		note_index += 1
	
		
func beat_hit(beat:int):
	if beat %zoom_beat == 0:
		hud.scale += zoom_amount
	pass
