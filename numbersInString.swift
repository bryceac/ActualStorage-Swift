// numbersInString function is used to get integer string from a string
func numbersInString(_ string: String) -> String {
    var number = "" // variable to contain numerical characters

    // the following loop goes through each character in a string and saves them to a new string
    for char in string {
        if Int(String(char)) != nil {
            number += String(char)
        }
    }
    return number // return a string with just numbers in it.
}