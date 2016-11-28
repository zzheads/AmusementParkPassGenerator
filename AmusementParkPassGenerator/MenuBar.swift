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
    
    var marginY: CGFloat {
        return CGFloat(ViewController.marginY)
    }
    
    var height: CGFloat {
        switch self {
        case .Top:
            return CGFloat(ViewController.marginY * ViewController.heightTopMenuInMargins)
        case .Bottom:
            return CGFloat(ViewController.marginY * ViewController.heightBottomMenuInMargins)
        }
    }
    
    var originY: CGFloat {
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
        let frame = CGRect(x: 0, y: Int(menuBar.originY), width: Int(UIScreen.main.bounds.size.width), height: Int(menuBar.height))
        super.init(frame: frame)
        self.backgroundColor = menuBar.color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar {
    func addButtons(navBar: MenuBars, titles: [String], target: Any?, action: Selector) -> [MenuButton] {
        var result: [MenuButton] = []
        for i in 0..<titles.count {
            let button = MenuButton(title: titles[i], position: i, number: titles.count, parentView: self, navBar: navBar, target: target, action: action)
            result.append(button)
        }
        return result
    }
}

extension Array where Element: MenuButton {
    func findByLabel(label: String) -> MenuButton? {
        let result = self.first { (menuButton) -> Bool in
            if menuButton.button.currentTitle == label {
                return true
            } else {
                return false
            }
        }
        return result
    }
}
