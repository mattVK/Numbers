class_name FormulaOperandContainer extends Control

var current_number : Variant = null
signal is_dropped_to_formula(data : OperandContainer, current_number : Variant)

func _set_number_text(number: Variant)-> void:
	current_number = number
	if number == null:
		$NumberText.text = ''
	else: 
		$NumberText.text = '[center]%s[/center]' % str(number)


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is OperandContainer
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	is_dropped_to_formula.emit(data, current_number)
	_set_number_text(data.number)
	
func reset():
	current_number =  null
	_set_number_text(null)
	
