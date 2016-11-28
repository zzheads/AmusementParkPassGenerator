//
//  Requirements.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Requirements

enum Requirements: String, CheckParent, CustomStringConvertible {
    case FirstName = "First Name"
    case LastName = "Last Name"
    case StreetAddress = "Street Address"
    case City = "City"
    case State = "State"
    case ZipCode = "Zip Code"
    case DateOfBirth = "Date of Birth"
    case ManagementTier = "Management Tier"
    case SocialSecurityNumber = "SSN"
    case ProjectNumber = "Project #"
    case VendorCompany = "Company"
    case DateOfVisit = "Date of Visit"
    
    var description: String {
        return self.rawValue
    }
    
    static var array: [Requirements] {
        return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode, .DateOfBirth, .ManagementTier, .SocialSecurityNumber, .ProjectNumber, .VendorCompany, .DateOfVisit]
    }
}

// MARK: - Requirements protocols

protocol Requirementable {
    var type: EntrantType { get }
    var requirements: [Requirements] { get }
}

extension Requirementable {
    var requirements: [Requirements] {
        switch self.type {
        case .GuestClassic, .GuestVip:                              return []
        case .GuestChild:                                           return [.DateOfBirth]
        case .GuestSenior:                                          return [.FirstName, .LastName, .DateOfBirth]
        case .GuestSeasonPass:                                      return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode, .DateOfBirth]
        case .EmployeeFood, .EmployeeRide, .EmployeeMaintenance:    return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode, .DateOfBirth, .SocialSecurityNumber]
        case .Manager:                                              return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode, .DateOfBirth, .SocialSecurityNumber, .ManagementTier]
        case .EmployeeContract:                                     return [.FirstName, .LastName, .StreetAddress, .City, .State, .ZipCode, .DateOfBirth, .SocialSecurityNumber, .ProjectNumber]
        case .Vendor:                                               return [.FirstName, .LastName, .DateOfBirth, .VendorCompany, .DateOfVisit]
        }
    }
}

// MARK: - Requirements Errors

enum RequirementsError: String, Error {
    case FirstName = "First Name"
    case LastName = "Last Name"
    case StreetAddress = "Street Address"
    case City = "City"
    case State = "State"
    case ZipCode = "Zip Code"
    case DateOfBirth = "Date of Birth"
    case ManagementTier = "Management Tier"
    case SocialSecurityNumber = "SSN"
    case ProjectNumber = "Project #"
    case VendorCompany = "Company"
    case DateOfVisit = "Date of Visit"
    case unknownError
    
    var localizedDescription: String {
        return self.rawValue
    }
}


