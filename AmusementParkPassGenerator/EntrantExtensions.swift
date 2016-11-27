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
        let firstName = self.info[.FirstName]!
        let lastName = self.info[.LastName]!
        
        if let firstName = firstName {
            if let lastName = lastName {
                return "\(firstName) \(lastName)"
            } else {
                return "\(firstName)"
            }
        }
        if let lastName = lastName {
            return "\(lastName)"
        }
        return nil
    }

    var address: String? {
        var address: String = ""
        if let streetAddress = self.info[.StreetAddress]! {
            address += "\(streetAddress), "
        }
        if let city = self.info[.City]! {
            address += "\(city), "
        }
        if let state = self.info[.State]! {
            address += "\(state), "
        }
        if let zipCode = self.info[.ZipCode]! {
            address += "\(zipCode)"
        }
        if !address.isEmpty {
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
        if let date = self.info[.DateOfBirth]! {
            descriptionString += "Born: \(date), "
        }
        if let management = self.info[.ManagementTier]! {
            descriptionString += "Tier: \(management), "
        }
        if let projectNumber = self.info[.ProjectNumber]! {
            descriptionString += "Project#: \(projectNumber), "
        }
        if let socialSecurityNumber = self.info[.SocialSecurityNumber]! {
            descriptionString += "SSN: \(socialSecurityNumber), "
        }
        if let vendorCompany = self.info[.VendorCompany]! {
            descriptionString += "Company: \(vendorCompany), "
        }
        if let dateOfVisit = self.info[.DateOfVisit]! {
            descriptionString += "Date of Visit: \(dateOfVisit), "
        }
        return descriptionString
    }
}

extension Entrant {
    
    func checkRequirements() throws {
        for (key, value) in self.info {
            if self.requirements.contains(key) {
                if let value = value {
                    if value.isEmpty {
                        if let error = RequirementsError(rawValue: key.rawValue) {
                            throw error
                        } else {
                            throw RequirementsError.unknownError
                        }
                    }
                } else {
                    if let error = RequirementsError(rawValue: key.rawValue) {
                        throw error
                    } else {
                        throw RequirementsError.unknownError
                    }
                }
            }
        }
    }
}
