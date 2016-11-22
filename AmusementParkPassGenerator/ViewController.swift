//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 19.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit
import CoreGraphics

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
    
    let textFieldsTitles: [TextFieldDesc] = [
        (posX: 0, totalX: 3, posY: 0, totalY: 5, title: "Date of Birth", isEditable: .Disabled,placeholder: "MM/DD/YYYY"),
        (posX: 1, totalX: 3, posY: 0, totalY: 5, title: "SSN", isEditable: .Disabled, placeholder: "###-##-####"),
        (posX: 2, totalX: 3, posY: 0, totalY: 5, title: "Project #", isEditable: .Disabled, placeholder: "#######"),
        (posX: 0, totalX: 2, posY: 1, totalY: 5, title: "First Name", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 2, posY: 1, totalY: 5, title: "Last Name", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 1, posY: 2, totalY: 5, title: "Company", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 1, posY: 3, totalY: 5, title: "Street Address", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 3, posY: 4, totalY: 5, title: "City", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 3, posY: 4, totalY: 5, title: "State", isEditable: .Disabled, placeholder: nil),
        (posX: 2, totalX: 3, posY: 4, totalY: 5, title: "Zip Code", isEditable: .Disabled, placeholder: nil),
    ]
    
    var topMenu: [MenuButton] = []
    var guestMenu: [MenuButton] = []
    var employeeMenu: [MenuButton] = []
    
    var wasSelected: UIButton?
    
    var genPassButton: UIButton?
    var popDataButton: UIButton?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainMenuBar)
        self.view.addSubview(guestMenuBar)
        self.view.addSubview(employeeMenuBar)
        self.view.addSubview(emptyMenuBar)
        self.activeMenuBar = emptyMenuBar

        self.topMenu = self.mainMenuBar.addButtons(navBar: .Top, titles: topMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.guestMenu = self.guestMenuBar.addButtons(navBar: .Bottom, titles: guestMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.employeeMenu = self.employeeMenuBar.addButtons(navBar: .Bottom, titles: employeeMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        
        var textFields: [TextField] = []
        for desc in textFieldsTitles {
            let textField = TextField(textFieldDesc: desc)
            textFields.append(textField)
            textField.appendTo(view: self.view)
        }
        textFields.findByLabel(label: "Date of Birth")?.enable()
        
        self.genPassButton = UIButton.getButton(type: .GeneratePass, target: self, action: #selector(generatePass(sender:)), parentView: self.view)
        self.popDataButton = UIButton.getButton(type: .PopulateData, target: self, action: #selector(populateData(sender:)), parentView: self.view)
        
        //TestingModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Listeners
    
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
    
    func generatePass(sender _: UIButton) {
        print("Generate pass!")
    }

    func populateData(sender _: UIButton) {
        print("Populate Data!")
    }
    
    // MARK: - Testing model methods
    
    func TestingModel() {
        let entrant = Entrant(type: EntrantType.Manager, firstName: "Alex", lastName: "Papin", streetAddress: "Bellemare blw", city: "Montreal", state: "QUE", zipCode: "400005", dateOfBirth: Date(), managementTier: "General Manager", socialSecurityNumber: "345-22-876521", projectNumber: "1003", vendorCompany: "Fedex", dateOfVisit: Date())
        let anotherEntrant = Entrant(type: .GuestVip)
        
        var ride = RideTurnstyle()
        entrant.swipe(unit: ride)
        anotherEntrant.swipe(unit: ride)
        ride.setDelegate { (entrant) -> (success: Bool, message: String) in
            let result: (success: Bool, message: String)
            result.success = true
            result.message = "Whoops, \(ride.name) is broken (by implementing my own checking method) and passes anybody!"
            return result
        }
        entrant.swipe(unit: ride)
        
        entrant.swipe(unit: OfficeDoor())
        entrant.swipe(unit: CashMachine())
        anotherEntrant.swipe(unit: OfficeDoor())
        anotherEntrant.swipe(unit: CashMachine())
    }
}

