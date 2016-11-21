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

class TextField: UITextField {
    static var offsetX: Int {
        return Int(Double(TextField.marginX) * 1.25)
    }
    static var offsetY: Int {
        return MenuBars.Top.marginY + MenuBars.Top.height + MenuBars.Bottom.height
    }
    static var offsetYFromBottom: Int {
        return Int(UIScreen.main.bounds.size.height) - ActionButtons.GeneratePass.y + MenuBars.Top.marginY * 2
    }
    static var marginX: Int {
        return Int(UIScreen.main.bounds.size.width / 28)      // width of text field depends of row, is 8 * marginX where 3 text field in the row
    }
    static var marginY: Int {
        return Int((Int(UIScreen.main.bounds.size.height) - offsetY - offsetYFromBottom) / 25)     // height of text field is 2 * marginY
    }
    static var height: Int {
        return TextField.marginY * 2
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
        let width = (27 * TextField.marginX) / totalX - TextField.marginX
        let x = TextField.offsetX + (width + TextField.marginX) * positionX
        let y = TextField.offsetY + TextField.marginY * 2 + (TextField.marginY * 5) * positionY
        let rect = CGRect(x: x, y: y, width: width, height: TextField.height)
        self.isEditable = .Disabled
        if let label = label {
            let labelRect = CGRect(x: x, y: y - Int(Double(TextField.marginY) * 1.2), width: width, height: TextField.marginY)
            self.label = UILabel(frame: labelRect)
            self.label?.text = label
            self.label?.font = UIFont.boldSystemFont(ofSize: 16)
        } else {
            self.label = nil
        }
        line = HorizontalLine(xStart: 0, xEnd: Int(UIScreen.main.bounds.size.width), y: y + Int(Double(TextField.marginY) * 3), color: AppColor.GrayHalfTransparent.rawValue)
        super.init(frame: rect)
        self.placeholder = placeholder
        self.borderStyle = UITextBorderStyle.roundedRect
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.disable()
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
