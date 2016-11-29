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
    case GuestClassic = "Adult"
    case GuestVip = "VIP"
    case GuestChild = "Child"
    case EmployeeFood = "Food Services"
    case EmployeeRide = "Ride Services"
    case EmployeeMaintenance = "Maintenance"
    case Manager = "Manager"
    case GuestSeasonPass = "Season"
    case GuestSenior = "Senior"
    case EmployeeContract = "Contract"
    case Vendor = "Vendor"
    
    var description: String {
        switch self {
        case .GuestClassic:          return "Adult Guest"
        case .GuestVip:              return "VIP Guest"
        case .GuestChild:            return "Child Guest"
        case .EmployeeFood:          return "Hourly Employee - Food Services"
        case .EmployeeRide:          return "Hourly Employee - Ride Services"
        case .EmployeeMaintenance:   return "Hourly Employee - Maintenance"
        case .Manager:               return "Manager"
        case .GuestSeasonPass:       return "Season Guest"
        case .GuestSenior:           return "Senior Guest"
        case .EmployeeContract:      return "Contract Employee"
        case .Vendor:                return "Vendor"
        }
    }
}

typealias EntrantInfo = [Requirements: String?]

class Entrant: Entrantable {
    let type: EntrantType
    var info: EntrantInfo = [:]
    
    init(type: EntrantType, firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, dateOfBirth: String? = nil, managementTier: String? = nil, socialSecurityNumber: String? = nil, projectNumber: String? = nil, vendorCompany: String? = nil, dateOfVisit: String? = nil) {
        self.type = type
        
        info.updateValue(firstName,             forKey: .FirstName)
        info.updateValue(lastName,              forKey: .LastName)
        info.updateValue(streetAddress,         forKey: .StreetAddress)
        info.updateValue(city,                  forKey: .City)
        info.updateValue(state,                 forKey: .State)
        info.updateValue(zipCode,               forKey: .ZipCode)
        info.updateValue(dateOfBirth,           forKey: .DateOfBirth)
        info.updateValue(managementTier,        forKey: .ManagementTier)
        info.updateValue(socialSecurityNumber,  forKey: .SocialSecurityNumber)
        info.updateValue(projectNumber,         forKey: .ProjectNumber)
        info.updateValue(vendorCompany,         forKey: .VendorCompany)
        info.updateValue(dateOfVisit,           forKey: .DateOfVisit)
    }
    
    init(type: EntrantType, dictionary: EntrantInfo) {
        self.type = type
        self.info = dictionary
    }
    
    func swipe(unit: CheckUnitType) -> CheckResult {
        let result = unit.check(self)
        if result.success {
            Sound.AccessGranted.play()
        } else {
            Sound.AccessDenied.play()
        }
        return result
    }
}

// MARK: - Entrant protocols

protocol Entrantable: Areable, Accessable, Discountable, Requirementable {
    var type: EntrantType { get }
    var name: String { get }
}

protocol Swiping {
    func swipe(unit: CheckUnitType)
}

// MARK: - Entrant helpers

extension Date {
    var toString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}
































