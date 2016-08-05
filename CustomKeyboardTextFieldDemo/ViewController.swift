import UIKit

class ViewController: UIViewController {
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let sampleTextView = SamplePickerTextField(frame: CGRect(x: 0, y: 20, width: 500, height: 44))
        sampleTextView.backgroundColor = UIColor.whiteColor()
        view.addSubview(sampleTextView)
        
        let sampleDatePickerTextView = SampleDatePickerTextField(frame: CGRect(x: 0, y: 200, width: 500, height: 44))
        sampleDatePickerTextView.backgroundColor = UIColor.whiteColor()
        view.addSubview(sampleDatePickerTextView)
    }
}

