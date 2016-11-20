//
//  NavigationBar.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 20.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

enum MenuBars {
    case Top
    case Bottom
    

    var marginY: Int {
        return 20
    }
    
    var height: Int {
        switch self {
        case .Top:
            return 60
        case .Bottom:
            return 45
        }
    }
    
    var originY: Int {
        switch self {
        case .Top:
            return marginY
        case .Bottom:
            return marginY + MenuBars.Top.height
        }
    }
    
    var color: UIColor {
        switch self {
        case .Top:
            return AppColor.Purple.rawValue
        case .Bottom:
            return AppColor.DarkPurple.rawValue
        }
    }
}

class MenuBar: UIView {
    init(menuBar: MenuBars) {
        let frame = CGRect(x: 0, y: menuBar.originY, width: Int(UIScreen.main.bounds.size.width), height: menuBar.height)
        super.init(frame: frame)
        self.backgroundColor = menuBar.color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
