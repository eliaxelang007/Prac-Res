extends Control

@export var dialogue_text: Label
@export var name_text: Label
@export var pose: TextureRect

@export var dialogue: Array[DialogueBox] = []
@export var dialogue_index := 0

func display_dialogue_box(dialogue_box: DialogueBox):
	dialogue_text.text = dialogue_box.dialogue
	name_text.text = dialogue_box.name
	pose.texture = dialogue_box.sprite

func _ready():
	set_process_input(true)
	
	assert(dialogue.size() >= 1, "No dialogue!")
	
	display_dialogue_box(dialogue[0])

func _input(ev):
	if Input.is_key_pressed(KEY_RIGHT):
		dialogue_index = (dialogue_index + 1) % dialogue.size()
		
		display_dialogue_box(dialogue[dialogue_index])
