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

    @IBOutlet weak var scrollView: UIScrollView!
    
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
    let guestMenuTitles = ["Child", "Adult", "Senior", "VIP", "Season"]
    let employeeMenuTitles = ["Food Services", "Ride Services", "Maintenance", "Contract"]
    
    let textFieldsTitles: [TextFieldDesc] = [
        (posX: 0, totalX: 3, posY: 0, totalY: 5, title: "Date of Birth", isEditable: .Disabled,placeholder: "MM/DD/YYYY"),
        (posX: 1, totalX: 3, posY: 0, totalY: 5, title: "SSN", isEditable: .Disabled, placeholder: "###-##-####"),
        (posX: 2, totalX: 3, posY: 0, totalY: 5, title: "Project #", isEditable: .Disabled, placeholder: "#######"),
        (posX: 0, totalX: 2, posY: 1, totalY: 5, title: "First Name", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 2, posY: 1, totalY: 5, title: "Last Name", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 2, posY: 2, totalY: 5, title: "Company", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 2, posY: 2, totalY: 5, title: "Management Tier", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 2, posY: 3, totalY: 5, title: "Street Address", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 2, posY: 3, totalY: 5, title: "City", isEditable: .Disabled, placeholder: nil),
        (posX: 0, totalX: 3, posY: 4, totalY: 5, title: "State", isEditable: .Disabled, placeholder: nil),
        (posX: 1, totalX: 3, posY: 4, totalY: 5, title: "Zip Code", isEditable: .Disabled, placeholder: nil),
        (posX: 2, totalX: 3, posY: 4, totalY: 5, title: "Date of Visit", isEditable: .Disabled, placeholder: "MM/DD/YYYY"),
    ]
    var textFields: [TextField] = []
    
    var topMenu: [MenuButton] = []
    var guestMenu: [MenuButton] = []
    var employeeMenu: [MenuButton] = []
    
    var wasSelected: UIButton?
    
    var genPassButton: UIButton?
    var popDataButton: UIButton?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.addSubview(mainMenuBar)
        self.scrollView.addSubview(guestMenuBar)
        self.scrollView.addSubview(employeeMenuBar)
        self.scrollView.addSubview(emptyMenuBar)
        self.activeMenuBar = emptyMenuBar

        self.topMenu = self.mainMenuBar.addButtons(navBar: .Top, titles: topMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.guestMenu = self.guestMenuBar.addButtons(navBar: .Bottom, titles: guestMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.employeeMenu = self.employeeMenuBar.addButtons(navBar: .Bottom, titles: employeeMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        
        for desc in textFieldsTitles {
            let textField = TextField(textFieldDesc: desc)
            self.textFields.append(textField)
            textField.appendTo(view: self.scrollView)
        }
        
        self.genPassButton = UIButton.getButton(type: .GeneratePass, target: self, action: #selector(generatePass(sender:)), parentView: self.scrollView)
        self.popDataButton = UIButton.getButton(type: .PopulateData, target: self, action: #selector(populateData(sender:)), parentView: self.scrollView)
        
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
        
        if let entrantType = EntrantType(rawValue: title) {
            for textField in self.textFields {
                textField.disable()
            }
            let reqs = Entrant(type: entrantType).requirements
            for req in reqs {
                if let textField = self.textFields.findByLabel(label: req.description) {
                    textField.enable()
                }
            }
        }
        
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
            break
        }
    }
    
    func generatePass(sender _: UIButton) {
        print("Generate pass!")
        
        guard let wasSelected = self.wasSelected, let title = wasSelected.currentTitle, let type = EntrantType(rawValue: title) else {
            print("wasSelected: \(self.wasSelected), title: \(self.wasSelected?.currentTitle), type: \(EntrantType(rawValue: (self.wasSelected?.currentTitle)!))")
            return
        }
        let firstName = self.textFields.findByLabel(label: "First Name")?.text
        let lastName = self.textFields.findByLabel(label: "Last Name")?.text
        let street = self.textFields.findByLabel(label: "Street Address")?.text
        let city = self.textFields.findByLabel(label: "City")?.text
        let state = self.textFields.findByLabel(label: "State")?.text
        let zipCode = self.textFields.findByLabel(label: "Zip Code")?.text
        let ssn = self.textFields.findByLabel(label: "SSN")?.text
        let project = self.textFields.findByLabel(label: "Project #")?.text
        let company = self.textFields.findByLabel(label: "Company")?.text
        let tier = self.textFields.findByLabel(label: "Management Tier")?.text
        let dateOfBirth = self.textFields.findByLabel(label: "Date of Birth")?.text
        let dateOfVisit = self.textFields.findByLabel(label: "Date of Visit")?.text
        
        let entrant = Entrant(type: type, firstName: firstName, lastName: lastName, streetAddress: street, city: city, state: state, zipCode: zipCode, dateOfBirth: dateOfBirth, managementTier: tier, socialSecurityNumber: ssn, projectNumber: project, vendorCompany: company, dateOfVisit: dateOfVisit)
        do {
            try entrant.checkRequirements()
            print("\(entrant)")
        } catch let error as RequirementsError {
            print("Error creating entrant, you have to enter all selected fields, there is no info: \(error.localizedDescription)")
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }

    func populateData(sender _: UIButton) {
        print("Populate Data!")
    }
    
    // MARK: - Testing model methods
    
    func TestingModel() {
        let entrant = Entrant(type: EntrantType.Manager, firstName: "Alex", lastName: "Papin", streetAddress: "Bellemare blw", city: "Montreal", state: "QUE", zipCode: "400005", dateOfBirth: "02/06/1974", managementTier: "General Manager", socialSecurityNumber: "345-22-876521", projectNumber: "1003", vendorCompany: "Fedex", dateOfVisit: "22/11/2016")
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
    
    // MARK: - Helpers
    
}

