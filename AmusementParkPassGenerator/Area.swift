//
//  Area.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Area

enum Area: CustomStringConvertible {
    case Amusement
    case Kitchen
    case RideControl
    case Maintenance
    case Office
    case DependOnProjectNumber
    case DependOnVendorCompany
    
    var description: String {
        switch self {
        case .Amusement: return "Amusement Areas"
        case .Kitchen: return "Kitchen Areas"
        case .RideControl: return "Ride Control Areas"
        case .Maintenance: return "Maintenance Areas"
        case .Office: return "Office Areas"
        case .DependOnProjectNumber: return "Access to areas depends on project number of employee"
        case .DependOnVendorCompany: return "Access to areas depends on company of the vendor"
        }
    }
}

// MARK: - Areas for Contract Employees

enum ProjectNumberArea: String {
    case Project_1001 = "1001"
    case Project_1002 = "1002"
    case Project_1003 = "1003"
    case Project_2001 = "2001"
    case Project_2002 = "2002"
    
    var areas: [Area] {
        switch self {
        case .Project_1001: return [.Amusement, .RideControl]
        case .Project_1002: return [.Amusement, .RideControl, .Maintenance]
        case .Project_1003: return [.Amusement, .RideControl, .Maintenance, .Kitchen, .Office]
        case .Project_2001: return [.Office]
        case .Project_2002: return [.Maintenance, .Kitchen]
        }
    }
    
    var dictionary: [String: ProjectNumberArea] {
        return [
            ProjectNumberArea.Project_1001.rawValue: ProjectNumberArea.Project_1001,
            ProjectNumberArea.Project_1002.rawValue: ProjectNumberArea.Project_1002,
            ProjectNumberArea.Project_1003.rawValue: ProjectNumberArea.Project_1003,
            ProjectNumberArea.Project_2001.rawValue: ProjectNumberArea.Project_2001,
            ProjectNumberArea.Project_2002.rawValue: ProjectNumberArea.Project_2002
        ]
    }
}

// MARK: - Areas for Vendors

enum VendorCompanyArea: String {
    case Acme = "Acme"
    case Orkin = "Orkin"
    case Fedex = "Fedex"
    case NWElectrical = "NW Electrical"
    
    var areas: [Area] {
        switch self {
        case .Acme:             return [.Kitchen]
        case .Orkin:            return [.Amusement, .RideControl, .Kitchen]
        case .Fedex:            return [.Maintenance, .Office]
        case .NWElectrical:     return [.Amusement, .RideControl, .Maintenance, .Kitchen, .Office]
        }
    }
    
    var dictionary: [String: VendorCompanyArea] {
        return [
            VendorCompanyArea.Acme.rawValue: VendorCompanyArea.Acme,
            VendorCompanyArea.Orkin.rawValue: VendorCompanyArea.Orkin,
            VendorCompanyArea.Fedex.rawValue: VendorCompanyArea.Fedex,
            VendorCompanyArea.NWElectrical.rawValue: VendorCompanyArea.NWElectrical,
        ]
    }
}

// MARK: - Area protocols

protocol Areable: Entrantable {
    var areas: [Area] { get }
}

extension Areable {
    var areas: [Area] {
        switch self.type {
        case .GuestClassic, .GuestVip, .GuestChild, .GuestSeasonPass, .GuestSenior:     return [.Amusement]
        case .EmployeeFood:                                                             return [.Amusement, .Kitchen]
        case .EmployeeRide:                                                             return [.Amusement, .RideControl]
        case .EmployeeMaintenance:                                                      return [.Amusement, .Kitchen, .RideControl, .Maintenance]
        case .Manager:                                                                  return [.Amusement, .Kitchen, .RideControl, .Maintenance, .Office]
        case .EmployeeContract:                                                         return [.DependOnProjectNumber]
        case .Vendor:                                                                   return [.DependOnVendorCompany]
        }
    }
}
