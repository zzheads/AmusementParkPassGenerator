//
//  TextField.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 21.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

enum TextFieldState {
    case Enabled
    case Disabled
    
    var backgroundColor: UIColor {
        switch self {
        case .Enabled: return .white
        case .Disabled: return AppColor.LightPurple.rawValue
        }
    }
    var color: UIColor {
        switch self {
        case .Enabled: return AppColor.EnabledTextField.rawValue
        case .Disabled: return AppColor.Gray.rawValue
        }
    }
}

typealias TextFieldDesc = (posX: Int, totalX: Int, posY: Int, totalY: Int, title: String, isEditable: TextFieldState, placeholder: String?)

class TextField: UITextField {
    static var offsetX: CGFloat {
        return marginX 
    }
    static var offsetY: CGFloat {
        return MenuBars.Top.height + MenuBars.Bottom.height + TextField.marginY * 1.5
    }
    static var offsetYFromBottom: CGFloat {
        return ViewController.offsetFromBottom + ActionButtons.GeneratePass.height
    }
    static var marginX: CGFloat {
        return ViewController.marginX      // width of text field depends of row, is 8 * marginX where 3 text field in the row
    }
    static var marginY: CGFloat {
        return ViewController.marginY
    }
    static var height: CGFloat {
        return TextField.marginY * ViewController.heightTextFieldInMargins
    }

    let label: UILabel?
    let line: HorizontalLine
    var isEditable: TextFieldState {
        didSet {
            if isEditable == .Enabled {
                self.isEnabled = true
            } else {
                self.isEnabled = false
            }
            self.backgroundColor = isEditable.backgroundColor
            self.layer.borderColor = isEditable.color.cgColor
            if let label = self.label {
                label.textColor = isEditable.color
            }
        }
    }
    
    
    // positionX - number ofTextField in the row
    // totalX - total number of text firlds in the row
    // positionY - number of row
    // positionY - total number of the rows WHITH text fields (!)
    // will calculate Rect with this information, plus know offset from Y (from MenuBars)
    init(positionX: Int, totalX: Int, positionY: Int, totalY: Int, isEditable: TextFieldState = .Disabled, label: String? = nil, placeholder: String? = nil) {
        
        let width = (27 * TextField.marginX) / CGFloat(totalX) - TextField.marginX
        let x = TextField.offsetX + (width + TextField.marginX) * CGFloat(positionX)
        let y = TextField.offsetY + TextField.height * CGFloat(positionY)
        let rect = CGRect(x: x, y: y + TextField.height / 4, width: width, height: TextField.height / 2)
        
        self.isEditable = .Disabled
        
        if let label = label {
            let labelRect = CGRect(x: x, y: y, width: width, height: TextField.height / 4)
            self.label = UILabel(frame: labelRect)
            self.label?.text = label
            self.label?.font = UIFont.boldSystemFont(ofSize: 16)
        } else {
            self.label = nil
        }
        
        line = HorizontalLine(xStart: 0, xEnd: Int(UIScreen.main.bounds.size.width), y: Int(y + TextField.height * 3.5 / 4), color: AppColor.GrayHalfTransparent.rawValue)
        super.init(frame: rect)

        let paddingRect = CGRect(x: 0, y: 0, width: 15, height: self.frame.height)
        let paddingView = UIView(frame: paddingRect)
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        
        self.placeholder = placeholder
        self.borderStyle = UITextBorderStyle.roundedRect
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.disable()
    }
    
    convenience init(textFieldDesc: TextFieldDesc) {
        let positionX = textFieldDesc.posX
        let totalX = textFieldDesc.totalX
        let positionY = textFieldDesc.posY
        let totalY = textFieldDesc.totalY
        let title = textFieldDesc.title
        let isEditable = textFieldDesc.isEditable
        let placeholder = textFieldDesc.placeholder
        self.init(positionX: positionX, totalX: totalX, positionY: positionY, totalY: totalY, isEditable: isEditable, label: title, placeholder: placeholder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appendTo(view: UIView) {
        if let label = self.label {
            view.addSubview(label)
        }
        view.addSubview(self.line)
        view.addSubview(self)
    }
    
    func enable() {
        self.isEditable = .Enabled
    }
    
    func disable() {
        self.isEditable = .Disabled
    }
}

extension Array where Element: TextField {
    func findByLabel(label: String) -> TextField? {
        let result = self.first { (textField) -> Bool in
            if textField.label?.text == label {
                return true
            } else {
                return false
            }
        }
        return result
    }
}

