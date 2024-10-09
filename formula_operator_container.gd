class_name FormulaOperatorContainer extends Control

var current_operator : Variant = null
signal is_dropped_to_formula(data : OperandContainer, current_operator : Variant)

func _set_operator_text(operator: Variant)-> void:
	current_operator = operator
	if operator == null:
		$OperatorText.text = ''
	else:
		$OperatorText.text = '[center]%s[/center]' % operator


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is OperatorContainer
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	is_dropped_to_formula.emit(data, current_operator)
	_set_operator_text(data.operator)
	
func reset():
	current_operator = null
	_set_operator_text(null)
