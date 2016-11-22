//
//  AccessCases.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol CheckParent {
    // Silence is golden
}

protocol CheckUnitType {
    var name: String { get }
 
    var checkRole: CheckParent? { get }
    
    var delegate: CheckFunc? { get set }
    var check: CheckFunc { get }
}

extension CheckUnitType {
    var name: String {
        let s = "\(self)"
        guard let index = s.characters.index(of: ".") else {
            return "\(self)"
        }
        return "[\(s.substring(from: s.characters.index(index, offsetBy: 1)).replacingOccurrences(of: "()", with: ""))]"
    }
    
    var check: CheckFunc {
        if let delegate = self.delegate {
            return delegate
        } else {
            return defaultCheck(entrant: )
        }
    }
    
    func defaultCheck(entrant: Entrantable) -> (success: Bool, message: String) {
        var result: (success: Bool, message: String) = (success: false, message: "Any checks was not implemented into \(self.name)")
        guard let checkRole = self.checkRole else {
            return result
        }
        if type(of: checkRole) == Area.self {
            result.success = entrant.areas.contains(checkRole as! Area)
            result.message = result.success ? "Access to \(self.name) area for \(entrant.name) is GRANTED!" : "Access to \(self.name) area for \(entrant.name) is DENIED!"
            return result
        }
        if type(of: checkRole) == Access.self {
            result.success = entrant.access.contains(checkRole as! Access)
            result.message = result.success ? "Access to \(self.name) for \(entrant.name) is GRANTED!" : "Access to \(self.name) for \(entrant.name) is DENIED!"
            return result
        }
        if type(of: checkRole) == Discount.self {
            if entrant.discount.food != 0 || entrant.discount.merchant != 0 {
                result.success = true
                result.message = "\(entrant.name) has \(entrant.discount.food)% discount for food and \(entrant.discount.merchant)% for merchandise at \(self.name)"
            } else {
                result.success = false
                result.message = "\(entrant.name) has no any discounts at \(self.name)"
            }
            return result
        }
        if type(of: checkRole) == Requirements.self {
            result.success = entrant.requirements.contains(checkRole as! Requirements)
            result.message = result.success ? "Requirements of \(self.name) are INCLUDED in requirements to \(entrant.name)" : "Requirements of \(self.name) are NOT INCLUDED in requirements to \(entrant.name)"
            return result
        }
        return result
    }
    
    mutating func setDelegate(action: @escaping CheckFunc) {
        self.delegate = action
    }
}





