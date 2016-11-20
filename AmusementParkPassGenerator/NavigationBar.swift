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
}

//func setupTopNavigationBar() {
//    topNavBar.backgroundColor = AppColor.Purple.rawValue
//    topNavBar.translatesAutoresizingMaskIntoConstraints = false
//    self.view.addSubview(topNavBar)
//    NSLayoutConstraint.activate([
//        topNavBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20),
//        topNavBar.heightAnchor.constraint(equalToConstant: 60),
//        topNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//        topNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        ])
//}

class NavigationBar: UIView {
    
    init(menuBar: MenuBars) {
        switch menuBar {
        case .Top:
            let frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 60)
            super.init(frame: frame)
            self.backgroundColor = AppColor.Purple.rawValue
        case .Bottom:
            let frame = CGRect(x: 0, y: 80, width: UIScreen.main.bounds.size.width, height: 45)
            super.init(frame: frame)
            self.backgroundColor = AppColor.DarkPurple.rawValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
