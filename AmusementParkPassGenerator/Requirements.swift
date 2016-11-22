//
//  Requirements.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Requirements

enum Requirements: CheckParent, CustomStringConvertible {
    case FirstName
    case LastName
    case StreetAddress
    case City
    case State
    case ZipCode
    case DateOfBirth
    case ManagementTier
    case SocialSecurityNumber
    case ProjectNumber
    case VendorCompany
    case DateOfVisit
    
    var description: String {
        switch self {
        case .FirstName: return "First Name"
        case .LastName: return "Last Name"
        case .City: return "City"
        case .DateOfBirth: return "Date of Birth"
        case .State: return "State"
        case .StreetAddress: return "Street Address"
        case .ZipCode: return "Zip Code"
        case .ManagementTier: return "Management Tier"
        case .SocialSecurityNumber: return "Social Security Number"
        case .ProjectNumber: return "Project Number"
        case .VendorCompany: return "Vendor Company"
        case .DateOfVisit: return "Date of Visit"
        }
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

enum RequirementsError: Error {
    case noFirstName
    case noLastName
    case noStreetAddress
    case noCity
    case noState
    case noZipCode
    case noDateOfBirth
    case noManagementTier
    case noSocialSecurityNumber
    case noProjectNumber
    case noVendorCompany
    case noDateOfVisit
    
    var rawValue: String {
        switch self {
        case .noFirstName: return "First Name"
        case .noLastName: return "Last Name"
        case .noStreetAddress: return "Street Address"
        case .noCity: return "City"
        case .noState: return "State"
        case .noZipCode: return "Zip Code"
        case .noDateOfBirth: return "Date of Birth"
        case .noManagementTier: return "Management Tier"
        case .noSocialSecurityNumber: return "Social Security Number"
        case .noProjectNumber: return "Project Number"
        case .noVendorCompany: return "Vendor Company"
        case .noDateOfVisit: return "Date of Visit"
        }
    }
}


