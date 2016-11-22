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

class Entrant: Areable, Accessable, Discountable, Requirementable, CustomStringConvertible {
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
    
    var projectNumberArea: ProjectNumberArea {
        ProjectNumberArea
    }
    
    var fullName: String? {
        if let firstName = self.firstName {
            if let lastName = self.lastName {
                return "\(firstName) \(lastName)"
            } else {
                return "\(firstName)"
            }
        }
        if let lastName = self.lastName {
            return "\(lastName)"
        }
        return nil
    }
    
    var address: String? {
        var address: String = ""
        if let streetAddress = self.streetAddress {
            address += streetAddress + ", "
        }
        if let city = self.city {
            address += city + ", "
        }
        if let state = self.state {
            address += state + ", "
        }
        if let zipCode = self.zipCode {
            address += zipCode
        }
        if address.characters.count > 0 {
            return address
        } else {
            return nil
        }
    }
    
    init(type: EntrantType, firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, dateOfBirth: Date? = nil, managementTier: String? = nil, socialSecurityNumber: String? = nil, projectNumber: String? = nil, vendorCompany: String? = nil, dateOfVisit: Date? = nil) throws {
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
        
        if self.requirements.contains(.FirstName) && firstName == nil {
            throw EntrantError.noFirstName
        }
        if self.requirements.contains(.LastName) && lastName == nil {
            throw EntrantError.noLastName
        }
        if self.requirements.contains(.StreetAddress) && streetAddress == nil {
            throw EntrantError.noStreetAddress
        }
        if self.requirements.contains(.City) && city == nil {
            throw EntrantError.noCity
        }
        if self.requirements.contains(.State) && state == nil {
            throw EntrantError.noState
        }
        if self.requirements.contains(.ZipCode) && zipCode == nil {
            throw EntrantError.noZipCode
        }
        if self.requirements.contains(.DateOfBirth) && dateOfBirth == nil {
            throw EntrantError.noDateOfBirth
        }
        if self.requirements.contains(.ManagementTier) && managementTier == nil {
            throw EntrantError.noManagementTier
        }
        if self.requirements.contains(.SocialSecurityNumber) && socialSecurityNumber == nil {
            throw EntrantError.noSocialSecurityNumber
        }
        if self.requirements.contains(.ProjectNumber) && projectNumber == nil {
            throw EntrantError.noProjectNumber
        }
        if self.requirements.contains(.VendorCompany) && vendorCompany == nil {
            throw EntrantError.noVendorCompany
        }
        if self.requirements.contains(.DateOfVisit) && dateOfVisit == nil {
            throw EntrantError.noDateOfVisit
        }
    }
    
    var description: String {
        var descriptionString: String = "Type: \(self.type.rawValue), "
        if let fullName = self.fullName {
            descriptionString += "Name: \(fullName), "
        }
        if let address = self.address {
            descriptionString += "Address: \(address), "
        }
        if let date = self.dateOfBirth {
            descriptionString += "Born: \(date.toString)"
        }
        if let management = self.managementTier {
            descriptionString += "Tier: \(management)"
        }
        if let socialSecurityNumber = self.socialSecurityNumber {
            descriptionString += "SSN: \(socialSecurityNumber)"
        }
        if let vendorCompany = self.vendorCompany {
            descriptionString += "Company: \(vendorCompany)"
        }
        if let dateOfVisit = self.dateOfVisit {
            descriptionString += "Date of Visit: \(dateOfVisit.toString)"
        }
        return descriptionString // FIXME
    }
    
    func swipe(for check: CheckUnitType) {
        check.check(for: self)
    }
}

// MARK: - Entrant protocols

protocol Entrantable {
    var type: EntrantType { get }
}

protocol Swiping {
    func swipe()
}

// MARK: - Entrant helpers

extension Date {
    var toString: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
}

































