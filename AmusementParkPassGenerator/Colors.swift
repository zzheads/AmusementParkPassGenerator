//
//  Colors.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 19.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

// MARK: - Colors in application

enum AppColor {
    case Purple
    case LightPurple
    case DarkGreen
    case DarkPurple
    case EnabledTextField
    case LightenPurple
    case Gray
    case GrayHalfTransparent
    case HalfTransparent
    case Transparent
    
    var rawValue: UIColor {
        switch self {
        case .Purple:
            return UIColor(red: 138/255.0, green: 109/255.0, blue: 170/255.0, alpha: 1.0)
        case .LightPurple:
            return UIColor(red: 219/255.0, green: 214/255.0, blue: 223/255.0, alpha: 1.0)
        case .DarkGreen:
            return UIColor(red: 88/255.0, green: 149/255.0, blue: 143/255.0, alpha: 1.0)
        case .DarkPurple:
            return UIColor(red: 63/255.0, green: 54/255.0, blue: 72/255.0, alpha: 1.0)
        case .EnabledTextField:
            return UIColor(red: 95/255.0, green: 93/255.0, blue: 97/255.0, alpha: 1.0)
        case .LightenPurple:
            return UIColor(red: 239/255.0, green: 236/255.0, blue: 241/255.0, alpha: 1.0)
        case .Gray:
            return UIColor(red: 157/255.0, green: 153/255.0, blue: 160/255.0, alpha: 1.0)
        case .GrayHalfTransparent:
            return UIColor(red: 157/255.0, green: 153/255.0, blue: 160/255.0, alpha: 0.5)
        case .HalfTransparent:
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
        case .Transparent:
            return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.0)
        }
    }
}
