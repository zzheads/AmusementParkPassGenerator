//
//  Pass.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 28.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class Pass: UIView {
    let image: UIImageView
    let nameLabel: UILabel
    let typeLabel: UILabel
    let infoLabel: UILabel
    
    init(entrant: Entrant) {
        self.image = UIImageView(image: #imageLiteral(resourceName: "FaceImageAsset.png"))
        self.nameLabel = UILabel()
        self.typeLabel = UILabel()
        self.infoLabel = UILabel()
        let unitY = SecondViewController.unitY
        let width = UIScreen.main.bounds.size.width - unitY
        let height = UIScreen.main.bounds.size.height / 2 - unitY * 2.5
        let rect = CGRect(x: unitY * 0.5, y: unitY * 1.5, width: width, height: height)
        super.init(frame: rect)
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        
        let holeWidth = unitY
        let holeHeight = unitY / 5
        let holeRect = CGRect(x: (width - holeWidth) / 2, y: unitY / 3, width: holeWidth, height: holeHeight)
        let hole = UIView(frame: holeRect)
        hole.backgroundColor = AppColor.LightPurple.rawValue
        hole.layer.cornerRadius = 5
        hole.layer.masksToBounds = true
        self.addSubview(hole)
        
        self.addSubview(self.image)
        self.image.layer.cornerRadius = 4
        self.image.layer.masksToBounds = true
        self.image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.image.topAnchor.constraint(equalTo: self.topAnchor, constant: unitY * 1.25),
            self.image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: unitY)
            ])
        
        self.nameLabel.text = entrant.fullName
        self.nameLabel.textColor = .black
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.image.topAnchor),
            self.nameLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: unitY * 0.5)
            ])
        
        self.typeLabel.text = "\(entrant.type.description) Pass"
        self.typeLabel.textColor = AppColor.Gray.rawValue
        self.typeLabel.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(self.typeLabel)
        self.typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.typeLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.typeLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: unitY * 0.5)
            ])

        var info: String = ""
        for area in entrant.areas {
            info += "• \(area.description)\n"
        }
        for access in entrant.access {
            info += "• \(access.description)\n"
        }
        if entrant.discount.food > 0 {
            info += "• \(entrant.discount.food)% Food Discount\n"
        }
        if entrant.discount.merchant > 0 {
            info += "• \(entrant.discount.merchant)% Merch Discount\n"
        }

        self.infoLabel.text = info
        self.infoLabel.numberOfLines = 0
        self.infoLabel.textColor = AppColor.Gray.rawValue
        self.infoLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(self.infoLabel)
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: unitY * 0.25),
            self.infoLabel.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: unitY * 0.5)
            ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
