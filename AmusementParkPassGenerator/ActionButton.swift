//
//  ActionButton.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 21.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

enum ActionButtons: String {
    case GeneratePass = "Generate Pass"
    case PopulateData = "Populate Data"
    
    var x: Int {
        switch self {
        case .GeneratePass:  return TextField.offsetX
        case .PopulateData:  return TextField.offsetX + width + TextField.marginX
        }
    }
    var y: Int {
        return Int(UIScreen.main.bounds.size.height) - 125
    }
    var width: Int {
        return (27 * TextField.marginX) / 2 - TextField.marginX
    }
    var height: Int {
        return TextField.height
    }
    var backgroundColor: UIColor {
        switch self {
        case .GeneratePass:  return AppColor.DarkGreen.rawValue
        case .PopulateData:  return AppColor.LightenPurple.rawValue
        }
    }
    var color: UIColor {
        switch self {
        case .GeneratePass:  return .white
        case .PopulateData:  return AppColor.DarkGreen.rawValue
        }
    }
}

class ActionButton: UIButton {
    let type: ActionButtons
    
    init(type: ActionButtons) {
        self.type = type
        let rect = CGRect(x: type.x, y: type.y, width: type.width, height: type.height)
        super.init(frame: rect)
        self.backgroundColor = type.backgroundColor
        self.setTitleColor(type.color, for: .normal)
        self.setTitle(type.rawValue, for: .normal)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        self.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
