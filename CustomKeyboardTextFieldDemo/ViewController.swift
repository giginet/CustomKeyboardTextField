import UIKit
import CustomKeyboardTextField

class ViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let samplePickerTextField = CustomKeyboardTextField<PickerKeyboardViewProvider<SamplePickerKeyboardDataSource>>()
        samplePickerTextField.backgroundColor = UIColor.whiteColor()
        view.addSubview(samplePickerTextField)
        
        let sampleDatePickerTextField = CustomKeyboardTextField<DatePickerKeyboardViewProvider<SampleDatePickerKeyboardDataSource>>()
        sampleDatePickerTextField.backgroundColor = UIColor.whiteColor()
        view.addSubview(sampleDatePickerTextField)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        samplePickerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: samplePickerTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 40),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
            NSLayoutConstraint(item: samplePickerTextField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: 8)
        ])
        
        sampleDatePickerTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 32),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .Top, relatedBy: .Equal, toItem: samplePickerTextField, attribute: .Bottom, multiplier: 1.0, constant: 20),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 8),
            NSLayoutConstraint(item: sampleDatePickerTextField, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view, attribute: .TrailingMargin, multiplier: 1.0, constant: 8)
        ])

    }
}

