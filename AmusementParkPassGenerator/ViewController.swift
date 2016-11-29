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
    
    var genPassButton: UIButton = UIButton(type: .system)
    var popDataButton: UIButton = UIButton(type: .system)
    
    static var offsetFromBottom: CGFloat = 310
    static var totalHeight: CGFloat {
        return CGFloat(UIScreen.main.bounds.size.height - offsetFromBottom)
    }
    static var numberOfTextFields: CGFloat {
        return CGFloat(self.textFieldsTitles[0].totalY)
    }
    static let heightTopMenuInMargins: CGFloat = 3.0
    static let heightBottomMenuInMargins: CGFloat = 2
    static let heightTextFieldInMargins: CGFloat = 5.0
    static let heightButtonInMargins: CGFloat = 3.0
    static var totalMargins: CGFloat {
        return heightTopMenuInMargins + heightBottomMenuInMargins + heightTextFieldInMargins * numberOfTextFields + heightButtonInMargins
    }
    static var marginY: CGFloat {
        return totalHeight / (totalMargins + 2)
    }
    static var marginX: CGFloat {
        return UIScreen.main.bounds.size.width / 28      // width of text field depends of row, is 8 * marginX where 3 text field in the row
    }

    static let textFieldsTitles: [TextFieldDesc] = [
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
    
    var mainMenuBar = MenuBar(menuBar: .Top)
    var guestMenuBar = MenuBar(menuBar: .Bottom)
    var employeeMenuBar = MenuBar(menuBar: .Bottom)
    var emptyMenuBar = MenuBar(menuBar: .Bottom)
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
    
    var topMenu: [MenuButton] = []
    var guestMenu: [MenuButton] = []
    var employeeMenu: [MenuButton] = []
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "logo.png")
        return image
    }()
    
    var wasSelected: UIButton?
    var isKeyboardShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genPassButton = UIButton.getButton(type: .GeneratePass, target: self, action: #selector(generatePass), parentView: self.view)
        popDataButton = UIButton.getButton(type: .PopulateData, target: self, action: #selector(populateData), parentView: self.view)
        
        self.view.addSubview(mainMenuBar)
        self.view.addSubview(guestMenuBar)
        self.view.addSubview(employeeMenuBar)
        self.view.addSubview(emptyMenuBar)
        self.activeMenuBar = emptyMenuBar

        self.topMenu = self.mainMenuBar.addButtons(navBar: .Top, titles: topMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.guestMenu = self.guestMenuBar.addButtons(navBar: .Bottom, titles: guestMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        self.employeeMenu = self.employeeMenuBar.addButtons(navBar: .Bottom, titles: employeeMenuTitles, target: self, action: #selector(buttonPressed(sender:)))
        
        for desc in ViewController.textFieldsTitles {
            let textField = TextField(textFieldDesc: desc)
            self.textFields.append(textField)
            textField.appendTo(view: self.view)
        }
        
        self.view.addSubview(self.image)
        self.image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.image.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -ViewController.offsetFromBottom / 2)
            ])
        
        
//        TestingModel()
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
        guard let entrant = getEntrant() else {
            print("Empty entrant")
            return
        }
        do {
            try entrant.checkRequirements()
            print("\(entrant)")
        } catch let error as RequirementsError {
            showAlert(title: "Can't create entrant", message: "You have to enter all selected fields, there is no info: \(error.localizedDescription)")
            return
        } catch let error as SyntaxError {
            showAlert(title: "Can't create entrant", message: "Incorrect data: \(error.localizedDescription)")
            return
        } catch let error {
            showAlert(title: "Error", message: "\(error.localizedDescription)")
            return
        }
        
        let secondViewController = SecondViewController(entrant: entrant)
        self.present(secondViewController, animated: false, completion: nil)
    }

    func populateData(sender _: UIButton) {
        guard let wasSelected = self.wasSelected, let title = wasSelected.currentTitle, let type = EntrantType(rawValue: title) else {
            showAlert(title: "Can't populate data", message: "You have to select type of entrant first")
            return
        }
        let reqs = Entrant(type: type).requirements
        var dict: EntrantInfo = [:]
        for req in reqs {
            let values = PopulateData.dict[req]!
            let randomNum = Int(arc4random_uniform(UInt32(values.count)))
            let randomValue = values[randomNum]
            dict.updateValue(randomValue, forKey: req)
        }
        let entrant = Entrant(type: type, dictionary: dict)
        setEntrant(entrant: entrant)
    }
    
    // MARK: - Testing model methods
    
//    func TestingModel() {
//        let entrant = Entrant(type: EntrantType.Manager, firstName: "Alex", lastName: "Papin", streetAddress: "Bellemare blw", city: "Montreal", state: "QUE", zipCode: "400005", dateOfBirth: "02/06/1974", managementTier: "General Manager", socialSecurityNumber: "345-22-876521", projectNumber: "1003", vendorCompany: "Fedex", dateOfVisit: "22/11/2016")
//        let anotherEntrant = Entrant(type: .GuestVip)
//        
//        var ride = RideTurnstyle()
//        entrant.swipe(unit: ride)
//        anotherEntrant.swipe(unit: ride)
//        ride.setDelegate { (entrant) -> (success: Bool, message: String) in
//            let result: (success: Bool, message: String)
//            result.success = true
//            result.message = "Whoops, \(ride.name) is broken (by implementing my own checking method) and passes anybody!"
//            return result
//        }
//        entrant.swipe(unit: ride)
//        
//        entrant.swipe(unit: OfficeDoor())
//        entrant.swipe(unit: CashMachine())
//        anotherEntrant.swipe(unit: OfficeDoor())
//        anotherEntrant.swipe(unit: CashMachine())
//    }
    
    // MARK: - Helpers

    func showAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func getEntrant() -> Entrant? {
        guard let wasSelected = self.wasSelected, let title = wasSelected.currentTitle, let type = EntrantType(rawValue: title) else {
            return nil
        }
        let reqs = Entrant(type: type).requirements
        var dict: EntrantInfo = [:]
        for req in reqs {
            dict.updateValue(self.textFields.findByLabel(label: req.rawValue)?.text, forKey: req)
        }
        let entrant = Entrant(type: type, dictionary: dict)
        return entrant
    }
    
    func setEntrant(entrant: Entrant?) {
        guard let entrant = entrant else {
            return
        }
        
        for req in Requirements.array {
            if let value = entrant.info[req] {
                self.textFields.findByLabel(label: req.rawValue)?.text = value
            }
        }
        
        let type = entrant.type
        if let wasSelected = self.wasSelected {
            wasSelected.unselect()
        }
        var allButtons = topMenu
        allButtons.append(contentsOf: guestMenu)
        allButtons.append(contentsOf: employeeMenu)
        if let button = allButtons.findByLabel(label: type.rawValue) {
            button.select()
            self.wasSelected = button.button
        }
    }
}

