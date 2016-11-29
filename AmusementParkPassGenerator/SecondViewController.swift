//
//  SecondViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 28.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    let entrant: Entrant
    let pass: Pass
    let line: HorizontalLine
    
    static var unitY: CGFloat {
        return UIScreen.main.bounds.size.height / 16
    }
    
    static var widthScreen: Int {
        return Int(UIScreen.main.bounds.size.width)
    }
    
    static var heightScreen: Int {
        return Int(UIScreen.main.bounds.size.height)
    }
    
    let newPassButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create New Pass", for: .normal)
        button.backgroundColor = AppColor.DarkGreen.rawValue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        return button
    }()
    
    let accessTestingLabel: UILabel = {
        let label = UILabel()
        label.text = "Access Testing"
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let accessTestingDescLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm the pass has the expected level of access when swiped at a kiosk."
        label.textColor = AppColor.Gray.rawValue
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let areaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Area Access", for: .normal)
        button.backgroundColor = AppColor.LightenPurple.rawValue
        button.setTitleColor(AppColor.DarkGreen.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()

    let rideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Area Access", for: .normal)
        button.backgroundColor = AppColor.LightenPurple.rawValue
        button.setTitleColor(AppColor.DarkGreen.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()

    let discountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Area Access", for: .normal)
        button.backgroundColor = AppColor.LightenPurple.rawValue
        button.setTitleColor(AppColor.DarkGreen.rawValue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    let testResult = TestResult()
    
    let newPassBottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.BlueGray.rawValue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Create New Pass", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    init(entrant: Entrant) {
        self.entrant = entrant
        self.pass = Pass(entrant: entrant)
        let lineY = CGFloat(SecondViewController.heightScreen) / 2 - SecondViewController.unitY / 4
        self.line = HorizontalLine(xStart: 0, xEnd: SecondViewController.widthScreen, y: Int(lineY), color: AppColor.Gray.rawValue)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(newPassButton)
        newPassButton.translatesAutoresizingMaskIntoConstraints = false
        //newPassButton.addTarget(self, action: #selector(newPassButtonPressed(sender:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            newPassButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: ViewController.marginY),
            newPassButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            newPassButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            newPassButton.heightAnchor.constraint(equalToConstant: SecondViewController.unitY)
            ])
        
        self.view.addSubview(pass)
        pass.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: SecondViewController.unitY * 1.5 + ViewController.marginY),
            pass.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY * 0.5),
            pass.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SecondViewController.unitY * 0.5),
            pass.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 2 - SecondViewController.unitY * 2.5)
            ])
        
        self.view.addSubview(line)
        
        self.view.addSubview(accessTestingLabel)
        accessTestingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessTestingLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: SecondViewController.unitY * 0.3),
            accessTestingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])

        self.view.addSubview(accessTestingDescLabel)
        accessTestingDescLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessTestingDescLabel.centerYAnchor.constraint(equalTo: accessTestingLabel.bottomAnchor, constant: SecondViewController.unitY * 0.2),
            accessTestingDescLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])
        
        let widthButton = (CGFloat(SecondViewController.widthScreen) - 2 * SecondViewController.unitY) / 3
        
        self.view.addSubview(areaButton)
        areaButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            areaButton.topAnchor.constraint(equalTo: accessTestingDescLabel.bottomAnchor, constant: SecondViewController.unitY * 0.5),
            areaButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY * 0.5),
            areaButton.widthAnchor.constraint(equalToConstant: widthButton),
            areaButton.heightAnchor.constraint(equalToConstant: SecondViewController.unitY)
            ])

        self.view.addSubview(rideButton)
        rideButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rideButton.topAnchor.constraint(equalTo: accessTestingDescLabel.bottomAnchor, constant: SecondViewController.unitY * 0.5),
            rideButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY + widthButton),
            rideButton.widthAnchor.constraint(equalToConstant: widthButton),
            rideButton.heightAnchor.constraint(equalToConstant: SecondViewController.unitY)
            ])

        self.view.addSubview(discountButton)
        discountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discountButton.topAnchor.constraint(equalTo: accessTestingDescLabel.bottomAnchor, constant: SecondViewController.unitY * 0.5),
            discountButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY * 1.5 + widthButton * 2),
            discountButton.widthAnchor.constraint(equalToConstant: widthButton),
            discountButton.heightAnchor.constraint(equalToConstant: SecondViewController.unitY)
            ])

        self.view.addSubview(testResult)
        testResult.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testResult.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY / 2),
            testResult.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SecondViewController.unitY / 2),
            testResult.topAnchor.constraint(equalTo: areaButton.bottomAnchor, constant: SecondViewController.unitY / 2),
            testResult.heightAnchor.constraint(equalToConstant: SecondViewController.unitY * 2.5)
            ])
        
        self.view.addSubview(newPassBottomButton)
        newPassBottomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newPassBottomButton.leftAnchor.constraint(equalTo: areaButton.rightAnchor, constant: -SecondViewController.unitY / 2),
            newPassBottomButton.rightAnchor.constraint(equalTo: discountButton.leftAnchor, constant: SecondViewController.unitY / 2),
            newPassBottomButton.topAnchor.constraint(equalTo: testResult.bottomAnchor, constant: SecondViewController.unitY / 2),
            newPassBottomButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -SecondViewController.unitY / 2)
            ])
        
        areaButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        rideButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        discountButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        newPassBottomButton.addTarget(self, action: #selector(newPassButtonPressed(sender:)), for: .touchUpInside)
    }
    
    func newPassButtonPressed(sender: UIButton) {
        let firstViewController = ViewController()
        present(firstViewController, animated: false, completion: nil)
    }
    
    func testButtonPressed(sender: UIButton) {
        let areaUnits: [CheckUnitType] = [OfficeDoor(), KitchenDoor(), AmusementDoor(), MaintenanceDoor(), RideControl()]
        let rideUnits: [CheckUnitType] = [RideTurnstyle(), SkipRideTurnstyle()]
        let discountUnits: [CheckUnitType] = [CashMachine()]
        
        switch sender {
        case areaButton:
            self.testResult.label.text = ""
            for i in 0..<areaUnits.count {
                delayWithSeconds(Double(i)) {
                    let text = self.testResult.label.text! + "\n" + self.entrant.swipe(unit: areaUnits[i]).message
                    self.testResult.label.text = text
                }
            }

        case rideButton:
            self.testResult.label.text = ""
            for i in 0..<rideUnits.count {
                delayWithSeconds(Double(i)) {
                    let text = self.testResult.label.text! + "\n" + self.entrant.swipe(unit: rideUnits[i]).message
                    self.testResult.label.text = text
                }
            }
            
        case discountButton:
            self.testResult.label.text = ""
            for i in 0..<discountUnits.count {
                delayWithSeconds(Double(i)) {
                    let text = self.testResult.label.text! + "\n" + self.entrant.swipe(unit: discountUnits[i]).message
                    self.testResult.label.text = text
                }
            }
            
        default:
            break
        }
    }
    
    // MARK: - Helpers
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
