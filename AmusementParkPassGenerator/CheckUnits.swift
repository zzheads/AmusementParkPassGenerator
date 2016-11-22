//
//  AccessCases.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol CheckUnitType {
    var name: String { get }
    var delegate: CheckFunc? { get }
}

extension CheckUnitType {
    var name: String {
        return "\(self)".replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    }
}

struct RideTurnstyle: CheckUnitType {
    var delegate: CheckFunc? {
        return check
    }
    
    func check(entrant: Entrantable) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        if entrant.access.contains(Access.AllRides) {
            result.success = true
            result.message = "Access to \(self.name) for \(entrant.name) is GRANTED!"
        } else {
            result.success = false
            result.message = "Access to \(self.name) for \(entrant.name) is DENIED!"
        }
        return result
    }
}

struct Kitchen: CheckUnitType {
    var delegate: CheckFunc? {
        return check
    }
    
    func check(entrant: Entrantable) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        if entrant.areas.contains(Area.Kitchen) {
            result.success = true
            result.message = "Access to \(self.name) for \(entrant.name) is GRANTED!"
        } else {
            result.success = false
            result.message = "Access to \(self.name) for \(entrant.name) is DENIED!"
        }
        return result
    }
}

struct CashRegister: CheckUnitType {
    var delegate: CheckFunc? {
        return check
    }
    
    func check(entrant: Entrantable) -> (success: Bool, message: String) {
        let result: (success: Bool, message: String)
        result.success = true
        result.message = "\(entrant.name) has \(entrant.discount.food)% discount for food and \(entrant.discount.merchant)% for merchandise at \(self.name)"
        return result
    }
}

// MARK: - CheckUnit errors

enum CheckUnitError: Error {
    case CheckFuncNotAssigned
    
    var message: String {
        switch self {
        case .CheckFuncNotAssigned: return "Check function not implemented or not assigned properly."
        }
    }
}

