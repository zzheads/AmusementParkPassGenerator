//
//  AccessCases.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

protocol CheckUnitType {
    func check(for entrant: Entrant)
}

struct RideTurnstyle: CheckUnitType {
    func check(for entrant: Entrant) {
        if entrant.access.contains(Access.AllRides) {
            print("Access to \(self) for \(entrant) is granted!")
        } else {
            print("Access to \(self) for \(entrant) denied!")
        }
    }
}

struct Kitchen: CheckUnitType {
    func check(entrant: Entrant) {
        switch entrant.type {
        case .EmployeeContract:
        case .Vendor:
        default:
            if entrant.areas.contains(Area.Kitchen) {
                print("Access to \(self) for \(entrant) is granted!")
            } else {
                print("Access to \(self) for \(entrant) denied!")
            }

        }
        
    }
}

struct CashRegister: CheckUnitType {
    func check(for entrant: Entrant) {
        print("\(entrant) has \(entrant.discount.food)% discount for food and \(entrant.discount.merchant)% for merchandise")
    }
}

