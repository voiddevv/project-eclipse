class_name Chart extends Resource

# varibles
@export var song_name:String = "bopeebo"
@export var notes:Array[NoteData] = []
@export var cpu_name:String = "dad"
@export var player_name:String = "boyfriend"
@export var spectator_name:String = "girlfriend"
@export var bpms:Dictionary = {}
@export var initial_bpm:float = 100.0

func save(path:String):
	ResourceSaver.save(self)

static func load_chart(song:String,diff:String):
	const BASE_SONG_PATH = "res://songs"
	var path:String = "%s/%s/%s"%[BASE_SONG_PATH, song, diff]
	var exist:bool = ResourceLoader.exists(path)
	if exist:
		print("%s Found Parsing"%path)
	else:
		print("%s Not Found"%path)
		return null
	var new_chart:Chart = Chart.new()

	match path.get_extension():
		"json":
			var _json:Dictionary = load(path).data.song
			new_chart.song_name = _json.song
			new_chart.cpu_name = _json.player2
			new_chart.player_name = _json.player1
			new_chart.initial_bpm = _json.bpm
			new_chart.bpms[0.0] = _json.bpm
			var section_index:int = 0
			for section in _json.notes:
				section_index += 1
				if section.has("changeBPM"):
					if section.changeBPM:
						var time:float = (60.0/new_chart.initial_bpm*4.0) * section_index
						new_chart.bpms[time] = section.bpm
				for note_data in section.sectionNotes: 
					var _note_data:NoteData = NoteData.new()
					_note_data.hit_time = float(note_data[0])*0.001
					
					_note_data.direction = int(note_data[1])%4
					_note_data.sustain_length = maxf(float(note_data[2])*0.001,0.0)
					_note_data.strum_id = int(section.mustHitSection) + floorf(note_data[1]/4)
					new_chart.notes.append(_note_data)
			
			new_chart.notes.sort_custom(func(a:NoteData,b:NoteData): return a.hit_time < b.hit_time)
		"res","tres":
			new_chart = load(path)
	return new_chart

func _to_string():
	return "bpms:%s\nsong: %s\ncpu:%s\nplayer:%s\nnotes:%s"%[self.bpms.values(),self.song_name,self.cpu_name,self.player_name,self.notes.size()]
