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
        label.font = UIFont.boldSystemFont(ofSize: 20)
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
    
    init(entrant: Entrant) {
        self.entrant = entrant
        self.pass = Pass(entrant: entrant)
        self.line = HorizontalLine(xStart: 0, xEnd: SecondViewController.widthScreen, y: SecondViewController.heightScreen / 2, color: AppColor.Gray.rawValue)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(newPassButton)
        newPassButton.translatesAutoresizingMaskIntoConstraints = false
        newPassButton.addTarget(self, action: #selector(newPassButtonPressed(sender:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            newPassButton.topAnchor.constraint(equalTo: self.view.topAnchor),
            newPassButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            newPassButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            newPassButton.heightAnchor.constraint(equalToConstant: SecondViewController.unitY)
            ])
        
        self.view.addSubview(pass)
        pass.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pass.topAnchor.constraint(equalTo: self.view.topAnchor, constant: SecondViewController.unitY * 1.5),
            pass.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: SecondViewController.unitY * 0.5),
            pass.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -SecondViewController.unitY * 0.5),
            pass.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height / 2 - SecondViewController.unitY * 2.5)
            ])
        
        self.view.addSubview(line)
        
        self.view.addSubview(accessTestingLabel)
        accessTestingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessTestingLabel.topAnchor.constraint(equalTo: line.topAnchor, constant: SecondViewController.unitY * 0.5),
            accessTestingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ])

        self.view.addSubview(accessTestingDescLabel)
        accessTestingDescLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            accessTestingDescLabel.topAnchor.constraint(equalTo: accessTestingLabel.bottomAnchor, constant: SecondViewController.unitY * 0.1),
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
        
        areaButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        rideButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        discountButton.addTarget(self, action: #selector(testButtonPressed(sender:)), for: .touchUpInside)
        
    }
    
    func newPassButtonPressed(sender: UIButton) {
        let firstViewController = ViewController()
        present(firstViewController, animated: false, completion: nil)
    }
    
    func testButtonPressed(sender: UIButton) {
        switch sender {
        case areaButton:
            var result = entrant.swipe(unit: OfficeDoor()).message + "\n"
            delayWithSeconds(1) {
                self.testResult.label.text = result
            }
            result += entrant.swipe(unit: KitchenDoor()).message + "\n"
            delayWithSeconds(2) {
                self.testResult.label.text = result
            }
            result += entrant.swipe(unit: AmusementDoor()).message + "\n"
            delayWithSeconds(3) {
                self.testResult.label.text = result
            }
            result += entrant.swipe(unit: MaintenanceDoor()).message + "\n"
            delayWithSeconds(4) {
                self.testResult.label.text = result
            }
            result += entrant.swipe(unit: RideControl()).message
            delayWithSeconds(5) {
                self.testResult.label.text = result
            }
        case rideButton:
            var result = self.entrant.swipe(unit: RideTurnstyle()).message + "\n"
            self.testResult.label.text = result
            sleep(5)
            result = result + self.entrant.swipe(unit: SkipRideTurnstyle()).message
            self.testResult.label.text = result
        case discountButton:
            self.testResult.label.text = entrant.swipe(unit: CashMachine()).message
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
