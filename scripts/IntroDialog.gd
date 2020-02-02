extends RichTextLabel

var dialog = ["You are Clyde, one of the best explorers ! Your task was to explore and chart the unknown parts of the world.\n\nUnfortunately, your ship has been caught and damaged by a storm and you are now stranded on an unexplored island. But not all hope is lost !\n\nYour ship is sturdy and the lost parts are probably intact, you must venture into the caves of this island to retrieve them and fix your ship.\n\nGood luck !\n\nPress any button to continue !"]
var page = 0

func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
