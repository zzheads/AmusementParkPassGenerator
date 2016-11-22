//
//  AccessCases.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol CheckUnitType {
    var delegate: CheckFunc? { get set }
}

struct RideTurnstyle: CheckUnitType {
    var delegate: CheckFunc?
    
    init() {
        self.delegate = check(entrant:)
    }
    
    func check(entrant: Entrant) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        if entrant.access.contains(Access.AllRides) {
            result.success = true
            result.message = "Access to \(self) for \(entrant) is granted!"
        } else {
            result.success = false
            result.message = "Access to \(self) for \(entrant) is denied!"
        }
        return result
    }
}

struct Kitchen: CheckUnitType {
    var delegate: CheckFunc?

    init() {
        self.delegate = check(entrant:)
    }
    
    func check(entrant: Entrant) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        if entrant.areas.contains(Area.Kitchen) {
            result.success = true
            result.message = "Access to \(self) for \(entrant) is granted!"
        } else {
            result.success = false
            result.message = "Access to \(self) for \(entrant) is denied!"
        }
        return result
    }
}

struct CashRegister: CheckUnitType {
    var delegate: CheckFunc?

    init() {
        self.delegate = check(entrant:)
    }
    
    func check(entrant: Entrant) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        result.success = true
        result.message = "\(entrant) has \(entrant.discount.food)% discount for food and \(entrant.discount.merchant)% for merchandise"
        return result
    }
}

