class_name OperandContainer extends Control

var number : int


func set_text(number: int):
	self.number = number
	$NumberText.text = '[center]%s[/center]' % str(number)

func _get_drag_data(at_position: Vector2) -> Variant:
	var drag_preview : = Control.new()
	
	var number_text_preview = $NumberText.duplicate()
	var hit_box_preview = $HitBox.duplicate()
	number_text_preview.position = Vector2(-0.5 * $NumberText.custom_minimum_size.x, -0.15 * $NumberText.custom_minimum_size.y)
	hit_box_preview.position = Vector2(-0.5 * $HitBox.custom_minimum_size.x, -0.4 * $HitBox.custom_minimum_size.y)
	drag_preview.add_child(number_text_preview)
	drag_preview.add_child(hit_box_preview)
	
	set_drag_preview(drag_preview)
	return self as OperandContainer
