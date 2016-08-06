import UIKit
import CustomKeyboardTextField

struct SamplePickerKeyboardDataSource: PickerKeyboardDataSource {
    let numberOfComponents = 1
    
    func rowTitles(by component: Int) -> [String] {
        return ["a", "b", "c"]
    }
}

typealias SamplePickerTextField = PickerKeyboardTextField<SamplePickerKeyboardDataSource>

struct SampleDatePickerKeyboardDataSource: DatePickerKeyboardDataSource { }

typealias SampleDatePickerTextField = DatePickerKeyboardTextField<SampleDatePickerKeyboardDataSource>

class ViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let samplePickerTextField = SamplePickerTextField()
        samplePickerTextField.backgroundColor = UIColor.whiteColor()
        view.addSubview(samplePickerTextField)
        samplePickerTextField.placeholder = "Picker"
        
        let sampleDatePickerTextField = SampleDatePickerTextField()
        sampleDatePickerTextField.backgroundColor = UIColor.whiteColor()
        view.addSubview(sampleDatePickerTextField)
        sampleDatePickerTextField.placeholder = "Date Picker"
        
        let gamePadTextField = GamePadKeyboardTextField()
        gamePadTextField.backgroundColor = UIColor.whiteColor()
        view.addSubview(gamePadTextField)
        gamePadTextField.placeholder = "Game Pad"
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        samplePickerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: samplePickerTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: -8)
        ])
        
        sampleDatePickerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .Top, relatedBy: .Equal, toItem: samplePickerTextField, attribute: .Bottom, multiplier: 1.0, constant: 20),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: -8)
        ])
        
        gamePadTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: gamePadTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
            NSLayoutConstraint(item: gamePadTextField, attribute: .Top, relatedBy: .Equal, toItem: sampleDatePickerTextField, attribute: .Bottom, multiplier: 1.0, constant: 20),
            NSLayoutConstraint(item: gamePadTextField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
            NSLayoutConstraint(item: gamePadTextField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: -8)
        ])
    }
}

