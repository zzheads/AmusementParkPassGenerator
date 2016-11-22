//
//  Entrant.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Entrant

enum EntrantType: String {
    case GuestClassic = "Classic Guest"
    case GuestVip = "VIP Guest"
    case GuestChild = "Free Child Guest"
    case EmployeeFood = "Hourly Employee - Food Services"
    case EmployeeRide = "Hourly Employee - Ride Services"
    case EmployeeMaintenance = "Hourly Employee - Maintenance"
    case Manager = "Manager"
    case GuestSeasonPass = "Season Pass Guest"
    case GuestSenior = "Senior Guest"
    case EmployeeContract = "Contract Employee"
    case Vendor = "Vendor"
}

typealias CheckFunc = (Entrantable) -> (success: Bool, message: String)

class Entrant: Entrantable {
    let type: EntrantType
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let dateOfBirth: Date?
    let managementTier: String?
    let socialSecurityNumber: String?
    let projectNumber: String?
    let vendorCompany: String?
    let dateOfVisit: Date?
    
    
    init(type: EntrantType, firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, dateOfBirth: Date? = nil, managementTier: String? = nil, socialSecurityNumber: String? = nil, projectNumber: String? = nil, vendorCompany: String? = nil, dateOfVisit: Date? = nil) {
        self.type = type
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dateOfBirth = dateOfBirth
        self.managementTier = managementTier
        self.socialSecurityNumber = socialSecurityNumber
        self.projectNumber = projectNumber
        self.vendorCompany = vendorCompany
        self.dateOfVisit = dateOfVisit
    }
        
    func swipe(unit: CheckUnitType) throws {
        guard let check = unit.delegate else {
            throw CheckUnitError.CheckFuncNotAssigned
        }
        
        let result = check(self)
        print(result.message)
    }
}

// MARK: - Entrant protocols

protocol Entrantable: Areable, Accessable, Discountable, Requirementable {
    var type: EntrantType { get }
    var name: String { get }
}

protocol Swiping {
    func swipe(unit: CheckUnitType) throws
}

// MARK: - Entrant helpers

extension Date {
    var toString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
































