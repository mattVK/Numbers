extends Node


#roll related vars
var rolled_numbers : Array[int] = []
var die_face : Array[int] = [1,2,3,4,5,6]
var number_of_rolls : int = 3

#formula related vars
var number_of_operators : int = 2 #number of operands is this + 1
var operators : Array[String] = ['+', '-', 'x', ':']

#combat related vars
var total_of_player_turn : int = 0
var total_of_enemy_turn : int = randi() % 20


func parse(formula_array: Array[String]) -> int:
	print(formula_array)
	var parsed_formula_array : Array[String] = formula_array
	var operator_list : Array[String] = []
	for index in range(1, formula_array.size(), 2):
		operator_list.append(formula_array[index])
	if (operator_list.size() * 2 + 1 > formula_array.size()):
		return 0
	
	
	for index in range(0, operator_list.size()):
		print (index)
		
		match operator_list[index]:
			'+':
				parsed_formula_array[2 * index + 2] = add(parsed_formula_array[index * 2], parsed_formula_array[2 * index + 2])
			'-':
				parsed_formula_array[2 * index + 2] = minus(parsed_formula_array[index * 2], parsed_formula_array[2 * index + 2])
			'x':
				parsed_formula_array[2 * index + 2] = mult(parsed_formula_array[index * 2], parsed_formula_array[2 * index + 2])
			':':
				parsed_formula_array[2 * index + 2] = div(parsed_formula_array[index * 2], parsed_formula_array[2 * index + 2])
				
					
	print(parsed_formula_array)
	return int(parsed_formula_array.back())
	
func add(number_one : String, number_two : String) -> String:
	var int_number_one : int = int(number_one)
	var int_number_two : int = int(number_two)
	
	return str(int_number_one + int_number_two)


func minus(number_one : String, number_two : String) -> String:
	var int_number_one : int = int(number_one)
	var int_number_two : int = int(number_two)
	
	return str(int_number_one - int_number_two)

func mult(number_one : String, number_two : String) -> String:
	var int_number_one : int = int(number_one)
	var int_number_two : int = int(number_two)
	
	return str(int_number_one * int_number_two)

func div(number_one : String, number_two : String) -> String:
	var int_number_one : int = int(number_one)
	var int_number_two : int = int(number_two)
	
	return str(int_number_one / int_number_two)
