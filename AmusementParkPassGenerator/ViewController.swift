//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 19.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainMenuBar = MenuBar(menuBar: .Top)
    let guestMenuBar = MenuBar(menuBar: .Bottom)
    let employeeMenuBar = MenuBar(menuBar: .Bottom)
    let emptyMenuBar = MenuBar(menuBar: .Bottom)
    var activeMenuBar: MenuBar? = nil {
        willSet {
            if self.activeMenuBar == nil {
                guestMenuBar.isHidden = true
                employeeMenuBar.isHidden = true
                emptyMenuBar.isHidden = true
            } else {
                self.activeMenuBar?.isHidden = true
            }
            
        }
        didSet {
            guard let activeMenuBar = self.activeMenuBar else {
                return
            }
            activeMenuBar.isHidden = false
        }
    }
    
    let topMenuTitles = ["Guest", "Employee", "Manager", "Vendor"]
    let guestMenuTitles = ["Child", "Adult", "Senior", "VIP"]
    let employeeMenuTitles = ["Food Services", "Ride Services", "Maintenance", "Contract"]
    
    var topMenu: [MenuButton] = []
    var guestMenu: [MenuButton] = []
    var employeeMenu: [MenuButton] = []
    
    var wasSelected: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainMenuBar)
        self.view.addSubview(guestMenuBar)
        self.view.addSubview(employeeMenuBar)
        self.view.addSubview(emptyMenuBar)
        self.activeMenuBar = emptyMenuBar

        for i in 0..<topMenuTitles.count {
            let button = MenuButton(title: topMenuTitles[i], position: i, number: topMenuTitles.count, parentView: mainMenuBar, navBar: .Top, target: self, action: #selector(buttonPressed(sender:)))
            topMenu.append(button)
        }

        for i in 0..<guestMenuTitles.count {
            let button = MenuButton(title: guestMenuTitles[i], position: i, number: guestMenuTitles.count, parentView: guestMenuBar, navBar: .Bottom, target: self, action: #selector(buttonPressed(sender:)))
            guestMenu.append(button)
        }

        for i in 0..<employeeMenuTitles.count {
            let button = MenuButton(title: employeeMenuTitles[i], position: i, number: employeeMenuTitles.count, parentView: employeeMenuBar, navBar: .Bottom, target: self, action: #selector(buttonPressed(sender:)))
            employeeMenu.append(button)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func buttonPressed(sender: UIButton) {
        guard let title = sender.currentTitle else {
            return
        }
        
        if let wasSelected = self.wasSelected {
            wasSelected.unselect()
        }
        sender.select()
        self.wasSelected = sender
        
        switch title {
        case "Guest":
            self.activeMenuBar = guestMenuBar
        case "Employee":
            self.activeMenuBar = employeeMenuBar
        case "Manager":
            self.activeMenuBar = emptyMenuBar
        case "Vendor":
            self.activeMenuBar = emptyMenuBar
            
        default:
            print("\(title) been pressed!")
        }
    }
    

}

