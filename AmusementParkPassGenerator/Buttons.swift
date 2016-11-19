//
//  Buttons.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 20.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit


extension UIButton {
    func setupButton(title: String, position: Int, parentView: UIView, target: Any? = nil , action: Selector? = nil) {
        self.backgroundColor = AppColor.Transparent.rawValue
        self.setTitleColor(AppColor.HalfTransparent.rawValue, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        self.isHidden = false
        parentView.addSubview(self)
        
        // calc width
        let width: CGFloat = (UIScreen.main.bounds.size.width - 40) / 4
        let height: CGFloat = 60
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
