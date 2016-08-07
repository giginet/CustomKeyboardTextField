import UIKit
import CustomKeyboardTextField

struct SimplePickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Bulbasaur", "Charmander", "Squirtle"]
}

typealias SimplePickerTextField = PickerKeyboardTextField<SimplePickerKeyboardDataSource>

struct GenderPickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let elements = ["Unknown", "Female", "Male"]
    
    func inputText(for row: Int) -> String? {
        if row == 0 {
            return nil
        }
        return elements[row]
    }
}

typealias GenderPickerTextField = PickerKeyboardTextField<GenderPickerKeyboardDataSource>

struct DateTimePickerKeyboardDataSource: UIDatePickerKeyboardDataSource { }

typealias DateTimePickerTextField = UIDatePickerKeyboardTextField<DateTimePickerKeyboardDataSource>

struct  DatePickerKeyboardDataSource: UIDatePickerKeyboardDataSource {
    let datePickerMode: UIDatePickerMode = .Date
    let timeFormat: String = "yyyy/MM/dd"
}

typealias DatePickerTextField = UIDatePickerKeyboardTextField<DatePickerKeyboardDataSource>

class ViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()

        let pickerTextField = SimplePickerTextField()
        pickerTextField.placeholder = "Picker"
        
        let genderPickerTextField = GenderPickerTextField()
        genderPickerTextField.placeholder = "Gender"

        let pokemonPickerTextField = PokemonPickerKeyboardTextField()
        pokemonPickerTextField.placeholder = "Rich Picker"

        let dateTimePickerTextField = DateTimePickerTextField()
        dateTimePickerTextField.placeholder = "Date Time Picker"

        let datePickerTextField = DatePickerTextField()
        datePickerTextField.placeholder = "Date Picker"

        let gamePadTextField = GamePadKeyboardTextField()
        gamePadTextField.placeholder = "Game Pad"

        view.translatesAutoresizingMaskIntoConstraints = false

        let textFields = [
            pickerTextField,
            genderPickerTextField,
            pokemonPickerTextField,
            dateTimePickerTextField,
            datePickerTextField,
            gamePadTextField
        ]

        for (index, textField) in textFields.enumerate() {
            textField.backgroundColor = UIColor.whiteColor()
            view.addSubview(textField)

            textField.translatesAutoresizingMaskIntoConstraints = false

            let topConstraints: NSLayoutConstraint
            if index == 0 {
                topConstraints = NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 40)
            } else {
                let previousField = textFields[index - 1]
                topConstraints = NSLayoutConstraint(item: textField, attribute: .Top, relatedBy: .Equal, toItem: previousField, attribute: .Top, multiplier: 1.0, constant: 40)
            }

            pickerTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addConstraints([
                NSLayoutConstraint(item: textField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
                topConstraints,
                NSLayoutConstraint(item: textField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
                NSLayoutConstraint(item: textField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: -8)
            ])
        }
    }
}
