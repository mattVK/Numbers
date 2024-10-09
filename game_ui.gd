extends Control

const OperandContainer : = preload("res://operand_container.tscn") as PackedScene
const OperatorContainer : = preload("res://operator_container.tscn") as PackedScene

@onready var rolled_number_text = $MainContainer/RolledNumberText
@onready var roll_button = $MainContainer/RollButton
@onready var calculate_button = $MainContainer/Calculate
@onready var operands = $MainContainer/Operands
@onready var operators = $MainContainer/Operators
@onready var formula = $MainContainer/Formula
@onready var player_total = $MainContainer/CombatScreen/PlayerTotal
@onready var enemy_total = $MainContainer/CombatScreen/EnemyTotal


func _ready():
	randomize()
	roll_button.pressed.connect(_on_roll_button_pressed)
	for formula_container in formula.get_children():
		if formula_container is FormulaOperandContainer:
			formula_container.is_dropped_to_formula.connect(_on_drop_to_formula)
	
	for operator in UiToGameManager.operators:
		var operator_container_instance = OperatorContainer.instantiate()
		operator_container_instance.set_text(operator)
		operators.add_child(operator_container_instance)
	
	enemy_total.text = str(UiToGameManager.total_of_enemy_turn)
	

	calculate_button.pressed.connect(_on_calculate_button_pressed)

func _on_calculate_button_pressed():
	
	for operand_container in operands.get_children():
		operand_container.queue_free()
	var formula_string : Array[String] = []
	for formula_container in formula.get_children():
		if formula_container is FormulaOperandContainer:
			if formula_container.current_number == null:
				continue
			else: 
				formula_string.append(str(formula_container.current_number))
		else:
			if formula_container.current_operator == null:
				continue
			else:
				formula_string.append(formula_container.current_operator)
	UiToGameManager.number_of_rolls = 3
	UiToGameManager.rolled_numbers.clear()
	for formula_container in formula.get_children():
		formula_container.reset()
	UiToGameManager.total_of_player_turn = UiToGameManager.parse(formula_string)
	player_total.text = str(UiToGameManager.total_of_player_turn)
	
	await get_tree().create_timer(1).timeout
	if UiToGameManager.total_of_enemy_turn < UiToGameManager.total_of_player_turn:
		get_tree().change_scene_to_file("res://win_node.tscn")
	else:
		UiToGameManager.total_of_player_turn = 0
		UiToGameManager.total_of_enemy_turn = randi() % 20
		enemy_total.text = str(UiToGameManager.total_of_enemy_turn)
		player_total.text = str(UiToGameManager.total_of_player_turn)
		
	

func _on_roll_button_pressed():
	var rolled_number = UiToGameManager.die_face[randi() % UiToGameManager.die_face.size()] as int
	
	UiToGameManager.number_of_rolls -= 1
	if UiToGameManager.number_of_rolls >= 0:
		UiToGameManager.rolled_numbers.append(rolled_number)
		
		var operand_container_instance = OperandContainer.instantiate()
		operand_container_instance.set_text(rolled_number)
		operands.add_child(operand_container_instance)
		
		_update_rolled_number_text()

func _on_drop_to_formula(dropped_container : OperandContainer, swapped_number : Variant) -> void:
	if swapped_number == null:
		UiToGameManager.rolled_numbers.remove_at(dropped_container.get_index())
	else: 
		UiToGameManager.rolled_numbers[dropped_container.get_index()] = swapped_number
	for operand_container in operands.get_children():
		operand_container.queue_free()
	for rolled_number in UiToGameManager.rolled_numbers:
		var operand_container_instance = OperandContainer.instantiate()
		operand_container_instance.set_text(rolled_number)
		operands.add_child(operand_container_instance)

func _update_rolled_number_text() -> void:
	rolled_number_text.text = "ROLL : %s" % UiToGameManager.rolled_numbers.back()
	
