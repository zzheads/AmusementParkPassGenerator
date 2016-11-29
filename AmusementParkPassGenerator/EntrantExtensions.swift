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
        var firstName: String?
        var lastName: String?
        
        if let firstNameInfo = self.info[.FirstName] {
            firstName = firstNameInfo
        }
        
        if let lastNameInfo = self.info[.LastName] {
            lastName = lastNameInfo
        }
        
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
        if let streetAddress = self.info[.StreetAddress], let addr = streetAddress {
            address += "\(addr), "
        }
        if let cityInfo = self.info[.City], let city = cityInfo {
            address += "\(city), "
        }
        if let stateInfo = self.info[.State], let state = stateInfo {
            address += "\(state), "
        }
        if let zipCodeInfo = self.info[.ZipCode], let zipCode = zipCodeInfo {
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
        if let dateInfo = self.info[.DateOfBirth], let date = dateInfo {
            descriptionString += "Born: \(date), "
        }
        if let managementInfo = self.info[.ManagementTier], let management = managementInfo {
            descriptionString += "Tier: \(management), "
        }
        if let projectNumberInfo = self.info[.ProjectNumber], let projectNumber = projectNumberInfo {
            descriptionString += "Project#: \(projectNumber), "
        }
        if let socialSecurityNumber = self.info[.SocialSecurityNumber], let ssn = socialSecurityNumber {
            descriptionString += "SSN: \(ssn), "
        }
        if let vendorCompany = self.info[.VendorCompany], let company = vendorCompany {
            descriptionString += "Company: \(company), "
        }
        if let dateOfVisit = self.info[.DateOfVisit], let date = dateOfVisit {
            descriptionString += "Date of Visit: \(date), "
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
                    } else {
                        if !key.predicate(value) {
                            if let error = SyntaxError(rawValue: key.rawValue) {
                                throw error
                            } else {
                                throw SyntaxError.unknownError
                            }
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
