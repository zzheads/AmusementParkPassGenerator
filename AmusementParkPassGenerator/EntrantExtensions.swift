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
            descriptionString += "Born: \(date), "
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
            descriptionString += "Date of Visit: \(dateOfVisit), "
        }
        return descriptionString
    }
}

extension Entrant {
    func checkRequirements() throws {
        let dict: [Requirements: String?] = [
            Requirements.FirstName              : self.firstName,
            Requirements.LastName               : self.lastName,
            Requirements.StreetAddress          : self.streetAddress,
            Requirements.City                   : self.city,
            Requirements.State                  : self.state,
            Requirements.ZipCode                : self.zipCode,
            Requirements.DateOfBirth            : self.dateOfBirth,
            Requirements.DateOfVisit            : self.dateOfVisit,
            Requirements.SocialSecurityNumber   : self.socialSecurityNumber,
            Requirements.ProjectNumber          : self.projectNumber,
            Requirements.ManagementTier         : self.managementTier,
            Requirements.VendorCompany          : self.vendorCompany
        ]
        
        for (key, value) in dict {
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
