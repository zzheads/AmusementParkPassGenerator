//
//  Buttons.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 20.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit


extension UIButton {
    func setupButton(title: String, position: Int, number: Int, parentView: UIView, navBar: MenuBars, target: Any? = nil , action: Selector? = nil) {
        self.backgroundColor = AppColor.Transparent.rawValue
        self.setTitleColor(AppColor.HalfTransparent.rawValue, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        self.isHidden = false
        parentView.addSubview(self)
        
        // calc width
        let width: CGFloat = (UIScreen.main.bounds.size.width - 40) / CGFloat(number)
        var height: CGFloat = 60
        if navBar == MenuBars.Bottom {
            height = 45
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentView.topAnchor),
            self.heightAnchor.constraint(equalToConstant: height),
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 8.0 + (width + 8.0) * CGFloat(position)),
            self.trailingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: (width + 8.0) + (width + 8) * CGFloat(position))
            ])
        if let target = target, let action = action {
            self.addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    func select() {
        self.setTitleColor(.white, for: .normal)
    }
    
    func unselect() {
        self.setTitleColor(AppColor.HalfTransparent.rawValue, for: .normal)
    }
}

class MenuButton {
    let button: UIButton
    var isSelected: Bool {
        didSet {
            if isSelected {
                self.select()
            } else {
                self.unselect()
            }
        }
    }
    
    init(button: UIButton, isSelected: Bool = false) {
        self.button = button
        self.isSelected = false
    }
    
    convenience init(title: String, position: Int, number: Int, parentView: UIView, navBar: MenuBars, target: Any? = nil, action: Selector? = nil, isSelected: Bool = false) {
        let button = UIButton(type: .system)
        button.setupButton(title: title, position: position, number: number, parentView: parentView, navBar: navBar, target: target, action: action)
        self.init(button: button, isSelected: isSelected)
    }
    
    func select() {
        self.button.select()
    }
    
    func show() {
        self.button.isHidden = false
    }

    func unselect() {
        self.button.unselect()
    }
    
    func hide() {
        self.button.isHidden = true
    }
    
    static func hide(buttons: [MenuButton]) {
        for button in buttons {
            button.hide()
        }
    }
    
    static func show(buttons: [MenuButton]) {
        for button in buttons {
            button.show()
        }
    }

}













