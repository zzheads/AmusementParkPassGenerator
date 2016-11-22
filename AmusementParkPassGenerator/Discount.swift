//
//  Discount.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Discount

typealias Percent = Int
struct Discount: CustomStringConvertible {
    let food: Percent
    let merchant: Percent
    
    var description: String {
        return "\(food)% discount on food, \(merchant)% discount on merchandise"
    }
}

// MARK: - Discount protocols

protocol Discountable {
    var type: EntrantType { get }
    var discount: Discount { get }
}

extension Discountable {
    var discount: Discount {
        switch self.type {
        case .GuestVip, .GuestSeasonPass: return Discount(food: 10, merchant: 20)
        case .GuestSenior: return Discount(food: 10, merchant: 10)
        case .EmployeeFood: return Discount(food: 15, merchant: 25)
        case .EmployeeRide: return Discount(food: 15, merchant: 25)
        case .EmployeeMaintenance: return Discount(food: 15, merchant: 25)
        case .Manager: return Discount(food: 25, merchant: 25)
        default: return Discount(food: 0, merchant: 0)
        }
    }
}
