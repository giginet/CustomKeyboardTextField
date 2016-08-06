import Foundation
import CustomKeyboardTextField

class GamePadKeyboardView: UIView {
    weak var textField: UITextField?
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let buttons = [
            aButton,
            bButton,
            startButton,
            selectButton,
            upButton,
            rightButton,
            downButton,
            leftButton
        ]
        
        for button in buttons {
            button.addTarget(self, action: #selector(buttonDidTap(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func buttonDidTap(sender: UIButton) {
        switch sender {
        case aButton: insertText("A")
        case bButton: insertText("B")
        case startButton: insertText("START")
        case selectButton: insertText("SELECT")
        case upButton: insertText("⬆️")
        case rightButton: insertText("➡️")
        case downButton: insertText("⬇️")
        case leftButton: insertText("⬅️")
        default: break
        }
    }
    
    private func insertText(insertText: String) {
        if let text = textField?.text {
            textField?.text = "\(text) \(insertText)"
        }
    }
}

class GamePadKeyboardProvider: CustomKeyboardViewProvider {
    weak var textField: UITextField!
    
    required init(with textField: UITextField) {
        self.textField = textField
    }
    
    func inputView() -> UIView? {
        let gamePadNib = UINib(nibName: "GamePadKeyboardView", bundle: nil)
        if let gamePad = gamePadNib.instantiateWithOwner(nil, options: nil).first as? GamePadKeyboardView {
            gamePad.textField = textField
            return gamePad
        }
        return nil
    }
    
    func inputAccessoryView() -> UIView? {
        return nil
    }
}

typealias GamePadKeyboardTextField = CustomKeyboardTextField<GamePadKeyboardProvider>