//
//  ViewController.swift
//  CustomKeyboardTextFieldDemo
//
//  Created by giginet on 8/5/16.
//  Copyright © 2016 giginet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let sampleTextView = SamplePickerTextField(frame: CGRect(x: 0, y: 20, width: 500, height: 44))
        sampleTextView.backgroundColor = UIColor.whiteColor()
        view.addSubview(sampleTextView)
        sampleTextView.delegate = self
    }


}

