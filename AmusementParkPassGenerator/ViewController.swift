//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 19.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topNavBar = UIView()
    let guestButton = UIButton(type: .system)
    let employeeButton = UIButton(type: .system)
    let managerButton = UIButton(type: .system)
    let vendorButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTopNavigationBar()
        let rect = CGRect(x: 100, y: 200, width: 100, height: 100)
        
        guestButton.setupButton(title: "Guest", position: 0, parentView: self.topNavBar, target: self, action: #selector(self.guestButtonPressed))
        guestButton.select()
        employeeButton.setupButton(title: "Employee", position: 1, parentView: self.topNavBar)
        employeeButton.unselect()
        managerButton.setupButton(title: "Manager", position: 2, parentView: self.topNavBar)
        managerButton.unselect()
        vendorButton.setupButton(title: "Employee", position: 3, parentView: self.topNavBar)
        vendorButton.unselect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTopNavigationBar() {
        topNavBar.backgroundColor = AppColor.Purple.rawValue
        topNavBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topNavBar)
        NSLayoutConstraint.activate([
            topNavBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 20),
            topNavBar.heightAnchor.constraint(equalToConstant: 60),
            topNavBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topNavBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    }
    
    @objc func guestButtonPressed(sender: UIBarButtonItem) {
        print("I've been pressed!")
    }
}

