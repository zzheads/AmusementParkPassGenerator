//
//  Access.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

// MARK: - Access

enum Access: CheckParent, CustomStringConvertible {
    case AllRides
    case SkipAllRideLines
    
    var description: String {
        switch self {
        case .AllRides: return "Access all rides"
        case .SkipAllRideLines: return "Skip all ride lines"
        }
    }
}

// MARK: - Access protocols

protocol Accessable {
    var type: EntrantType { get }
    var access: [Access] { get }
}

extension Accessable {
    var access: [Access] {
        switch self.type {
        case .GuestVip, .GuestSeasonPass, .GuestSenior:     return [.AllRides, .SkipAllRideLines]
        default:                                            return [.AllRides]
        }
    }
}
