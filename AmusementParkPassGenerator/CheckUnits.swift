//
//  CheckUnits.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 22.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

class RideTurnstyle: CheckUnitType {
    let checkRole: CheckParent? = Access.AllRides
    var delegate: CheckFunc? = nil
}

class SkipRideTurnstyle: CheckUnitType {
    let checkRole: CheckParent? = Access.SkipAllRideLines
    var delegate: CheckFunc? = nil
}


class OfficeDoor: CheckUnitType {
    let checkRole: CheckParent? = Area.Office
    var delegate: CheckFunc? = nil
}

class AmusementDoor: CheckUnitType {
    let checkRole: CheckParent? = Area.Amusement
    var delegate: CheckFunc? = nil
}

class KitchenDoor: CheckUnitType {
    let checkRole: CheckParent? = Area.Kitchen
    var delegate: CheckFunc? = nil
}

class MaintenanceDoor: CheckUnitType {
    let checkRole: CheckParent? = Area.Maintenance
    var delegate: CheckFunc? = nil
}

class RideControl: CheckUnitType {
    let checkRole: CheckParent? = Area.RideControl
    var delegate: CheckFunc? = nil
}

class CashMachine: CheckUnitType {
    let checkRole: CheckParent? = Discount(food: 0, merchant: 0)
    var delegate: CheckFunc? = nil
}
