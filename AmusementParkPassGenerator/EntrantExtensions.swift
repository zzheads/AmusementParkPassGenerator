//
//  EntrantDescription.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation


// MARK: - Entrant extensions

extension Entrant: CustomStringConvertible {

    var name: String {
        if let fullName = self.fullName {
            return fullName
        } else {
            return "Noname of \(self.type) type"
        }
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

    var description: String {
        var descriptionString: String = "Type: \(self.type.rawValue), "
        if let fullName = self.fullName {
            descriptionString += "Name: \(fullName), "
        }
        if let address = self.address {
            descriptionString += "Address: \(address), "
        }
        if let date = self.dateOfBirth {
            descriptionString += "Born: \(date.toString), "
        }
        if let management = self.managementTier {
            descriptionString += "Tier: \(management), "
        }
        if let projectNumber = self.projectNumber {
            descriptionString += "Project#: \(projectNumber), "
        }
        if let socialSecurityNumber = self.socialSecurityNumber {
            descriptionString += "SSN: \(socialSecurityNumber), "
        }
        if let vendorCompany = self.vendorCompany {
            descriptionString += "Company: \(vendorCompany), "
        }
        if let dateOfVisit = self.dateOfVisit {
            descriptionString += "Date of Visit: \(dateOfVisit.toString), "
        }
        return descriptionString
    }
}

extension Entrant {
    func checkRequirements() throws {
        if self.requirements.contains(.FirstName) && self.firstName == nil {
            throw RequirementsError.noFirstName
        }
        if self.requirements.contains(.LastName) && self.lastName == nil {
            throw RequirementsError.noLastName
        }
        if self.requirements.contains(.StreetAddress) && self.streetAddress == nil {
            throw RequirementsError.noStreetAddress
        }
        if self.requirements.contains(.City) && self.city == nil {
            throw RequirementsError.noCity
        }
        if self.requirements.contains(.State) && self.state == nil {
            throw RequirementsError.noState
        }
        if self.requirements.contains(.ZipCode) && self.zipCode == nil {
            throw RequirementsError.noZipCode
        }
        if self.requirements.contains(.DateOfBirth) && self.dateOfBirth == nil {
            throw RequirementsError.noDateOfBirth
        }
        if self.requirements.contains(.ManagementTier) && self.managementTier == nil {
            throw RequirementsError.noManagementTier
        }
        if self.requirements.contains(.SocialSecurityNumber) && self.socialSecurityNumber == nil {
            throw RequirementsError.noSocialSecurityNumber
        }
        if self.requirements.contains(.ProjectNumber) && self.projectNumber == nil {
            throw RequirementsError.noProjectNumber
        }
        if self.requirements.contains(.VendorCompany) && self.vendorCompany == nil {
            throw RequirementsError.noVendorCompany
        }
        if self.requirements.contains(.DateOfVisit) && self.dateOfVisit == nil {
            throw RequirementsError.noDateOfVisit
        }
    }
}
