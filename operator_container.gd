class_name OperatorContainer extends Control

var operator : String


func set_text(operator: String):
	self.operator = operator
	$OperatorText.text = '[center]%s[/center]' % operator

func _get_drag_data(at_position: Vector2) -> Variant:
	var drag_preview : = Control.new()
	
	var number_text_preview = $OperatorText.duplicate()
	var hit_box_preview = $Border.duplicate()
	number_text_preview.position = Vector2(-0.5 * $OperatorText.custom_minimum_size.x, -0.15 * $OperatorText.custom_minimum_size.y)
	hit_box_preview.position = Vector2(-0.5 * $Border.custom_minimum_size.x, -0.4 * $Border.custom_minimum_size.y)
	drag_preview.add_child(number_text_preview)
	drag_preview.add_child(hit_box_preview)
	
	set_drag_preview(drag_preview)
	return self as OperatorContainer
