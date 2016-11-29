//
//  TestResult.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 29.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class TestResult: UIView {
    let label: UILabel
    
    init() {
        self.label = UILabel()
        self.label.text = "Test Results"
        self.label.font = UIFont.systemFont(ofSize: 17)
        self.label.textColor = .darkGray
        self.label.numberOfLines = 0
        
        let width = CGFloat(SecondViewController.widthScreen) - SecondViewController.unitY
        let height = SecondViewController.unitY * 2.5
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        super.init(frame: rect)

        self.backgroundColor = AppColor.BlueGray.rawValue
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
