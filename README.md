# CustomKeyboardTextField

[![Build Status](https://travis-ci.org/giginet/CustomKeyboardTextField.svg?branch=master)](https://travis-ci.org/giginet/CustomKeyboardTextField) 
[![codecov](https://codecov.io/gh/giginet/CustomKeyboardTextField/branch/master/graph/badge.svg)](https://codecov.io/gh/giginet/CustomKeyboardTextField)
[![Language](https://img.shields.io/badge/language-Swift%202.2-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/cocoapods/p/CustomKeyboardTextField.svg?style=flat)](http://cocoadocs.org/docsets/CustomKeyboardTextField)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/CustomKeyboardTextField.svg)](https://img.shields.io/cocoapods/v/CustomKeyboardTextField.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/github/license/giginet/CustomKeyboardTextField.svg)](https://github.com/giginet/CustomKeyboardTextField/blob/master/LICENSE.md)

![](https://raw.githubusercontent.com/giginet/CustomKeyboardTextField/master/Documentation/Image/demo.gif)

CustomKeyboardTextField provides easy way to make TextField with custom keyboards.

# Demo

[Demo application](https://appetize.io/app/jv8ddk9ff2uwnf7hr508kbrkwg?device=iphone5s&scale=100&orientation=portrait&osVersion=9.3) is available on Appetize.io.

# Usage

## Simple Picker

![](https://raw.githubusercontent.com/giginet/CustomKeyboardTextField/master/Documentation/Image/picker.png)

```swift
import CustomKeyboardTextField

struct SimplePickerKeyboardDataSource: UIPickerViewKeyboardDataSource {
    let rowTitles = ["Bulbasaur", "Charmander", "Squirtle"]
}

typealias SimplePickerTextField = PickerKeyboardTextField<SimplePickerKeyboardDataSource>

let pickerTextField = SimplePickerTextField()
addSubView(pickerTextField)
```

You can also implement rich picker views. See [sample implementation](https://github.com/giginet/CustomKeyboardTextField/blob/master/CustomKeyboardTextFieldDemo/CustomKeyboard.swift#L10) for detail.

## Date Picker

![](https://raw.githubusercontent.com/giginet/CustomKeyboardTextField/master/Documentation/Image/date_picker.png)


```swift
import CustomKeyboardTextField

struct  DatePickerKeyboardDataSource: UIDatePickerKeyboardDataSource {
    let datePickerMode: UIDatePickerMode = .Date
    let timeFormat: String = "yyyy/MM/dd"
}

typealias DatePickerTextField = UIDatePickerKeyboardTextField<DatePickerKeyboardDataSource>
```

You can configure some parameters in `UIDatePickerKeyboardDataSource`.

## Custom Keyboard

![](https://raw.githubusercontent.com/giginet/CustomKeyboardTextField/master/Documentation/Image/custom.png)

You can implement own custom keyboard easily.

### 1. Implement the custom keyboard view

```swift
// Your custom view
class MyCustomKeyboardView: UIView, CustomKeyboardView {
    weak var textField: UITextField?
    var currentText: String = "Current text"
}
```

You can put some controls on your keyboard (button, switch, text fields etc...).
When these are interacted, you execute `updateTextField()` then `currentText` is reflected in the text field. 

### 2. Define `CustomKeyboardProvider`

```swift
struct MyKeyboardProvider: CustomKeyboardProvider {
    weak var textField: UITextField!

    init(with textField: UITextField) {
        self.textField = textField
    }

    func inputView(with textField: UITextField) -> CustomKeyboardView? {
        // Return keyboard view
        let myKeyboardView = MyCustomKeyboardView()
        myKeyboardView.textField = textField
        return myKeyboardView
    }

    func inputAccessoryView(with textField: UITextField) -> CustomKeyboardAccessoryView? {
        // Return accessoryView or nil
        // ToolbarKeyboardAccessoryView is built-in
        // Of cource, you can implement your own toolbars
        let accessoryView = ToolbarKeyboardAccessoryView(with: textField)
        return accessoryView
    }
}
```

### 3. Define `CustomKeyboardTextField`

```swift
typealias MyKeyboardTextField = CustomKeyboardTextField<MyKeyboardProvider>
```



See [sample implementation](https://github.com/giginet/CustomKeyboardTextField/blob/master/CustomKeyboardTextFieldDemo/CustomKeyboard.swift#L69) for detail.


# Installation

## Carthage

```
github "giginet/CustomKeyboardTextField"
```

## CocoaPods

```ruby
use_frameworks!

pod "CustomKeyboardTextField"
```

# Requirements

- iOS 8 or above
- Swift 2.2

# Author

giginet <<giginet.net@gmail.com>>

# LICENSE

MIT License
