//
//  TextFieldPredicates.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 29.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

typealias TextFieldPredicate = (String) -> Bool

enum SyntaxError: String, Error {
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
        switch self {
        case .FirstName: return "First Name can not be empty"
        case .LastName: return "Last Name can not be empty"
        case .StreetAddress: return "Street Address can not be empty"
        case .City: return "City can not be empty"
        case .State: return "State can not be empty"
        case .ZipCode: return "Zip Code can not be empty"
        case .DateOfBirth: return "Date of Birth must be in format DD/MM/YYYY"
        case .ManagementTier: return "Management Tier can not be empty"
        case .SocialSecurityNumber: return "Social Security Number must be in format ###-##-####"
        case .ProjectNumber: return "Illegal Project Number (####)"
        case .VendorCompany: return "Illegal Vendor Company"
        case .DateOfVisit: return "Date of Visit must be in format DD/MM/YYYY"
        case .unknownError: return "Unknown syntax error"
        }
    }
}

// MARK: - Requirements extension
// MARK: - Text Field validation here
// MARK: - You can implement any validation for specific Requirements by defining predicate (String -> Bool) here

// MARK: - Validation Zip Code: Can not implement, because zip codes around the world doesnt have common pattern

extension Requirements {
    var predicate: TextFieldPredicate {
        switch self {
        case .SocialSecurityNumber:
            // ###-##-####
            return { text in
                if text.isEmpty {
                    return false
                } else {
                    let pattern = "\\d{3}-\\d{2}-\\d{4}"
                    let regex = try! NSRegularExpression(pattern: pattern, options: [])
                    let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
                    if !matches.isEmpty {
                        return true
                    } else {
                        return false
                    }
                }
        }
        case .DateOfBirth, .DateOfVisit:
            // ##/##/####
            return { text in
                if text.isEmpty {
                    return false
                } else {
                    let pattern = "\\d{2}/\\d{2}/\\d{4}"
                    let regex = try! NSRegularExpression(pattern: pattern, options: [])
                    let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
                    if !matches.isEmpty {
                        return true
                    } else {
                        return false
                    }
                }
        }
        case .ProjectNumber:
            // ####
            return { text in
                if text.isEmpty {
                    return false
                } else {
                    let projectNumber = ProjectNumberArea(rawValue: text)
                    if projectNumber != nil {
                        return true
                    } else {
                        return false
                    }
                }
        }
        case .VendorCompany:
            return { text in
                if text.isEmpty {
                    return false
                } else {
                    let vendorCompany = VendorCompanyArea(rawValue: text)
                    if vendorCompany != nil {
                        return true
                    } else {
                        return false
                    }
                }
        }
        default:
            return { text in
                if text.isEmpty {
                    return false
                } else {
                    return true
                }
            }
        }
    }
}
