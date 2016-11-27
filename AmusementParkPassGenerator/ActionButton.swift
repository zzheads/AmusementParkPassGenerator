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
    
    var x: CGFloat {
        switch self {
        case .GeneratePass:  return ViewController.marginX
        case .PopulateData:  return ViewController.marginX * 2 + width
        }
    }
    var y: CGFloat {
        return UIScreen.main.bounds.size.height - ViewController.offsetFromBottom - height
    }
    var width: CGFloat {
        return (27 * ViewController.marginX) / 2 - ViewController.marginX
    }
    var height: CGFloat {
        return ViewController.marginY * ViewController.heightButtonInMargins
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

extension UIButton {
    static func getButton(type: ActionButtons, target: Any?, action: Selector, parentView: UIView) -> UIButton {
        let result = UIButton(type: .system)
        
        result.backgroundColor = type.backgroundColor
        result.setTitleColor(type.color, for: .normal)
        result.setTitle(type.rawValue, for: .normal)
        result.layer.cornerRadius = 4
        result.layer.masksToBounds = true
        result.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        result.isHidden = false
        result.addTarget(target, action: action, for: .touchUpInside)
        parentView.addSubview(result)
        result.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            result.topAnchor.constraint(equalTo: parentView.topAnchor, constant: CGFloat(type.y)),
            result.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: CGFloat(type.x)),
            result.widthAnchor.constraint(equalToConstant: CGFloat(type.width)),
            result.heightAnchor.constraint(equalToConstant: CGFloat(type.height))
            ])
        
        return result
    }
}

