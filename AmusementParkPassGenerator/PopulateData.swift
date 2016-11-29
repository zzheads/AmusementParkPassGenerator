//
//  PopulateData.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 28.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import Foundation

class PopulateData {
    static let dict: [Requirements: [String]] = [
        .FirstName: ["John", "Alexey", "Chris", "Sidney", "Mario", "Patric", "Victor"],
        .LastName: ["Doe", "Papin", "Rea", "Crosby", "Malkin", "Lemeux", "Roy", "Ivanoff"],
        .StreetAddress: ["Bellemare str 11-12", "825 Dawson Dr", "69 Axes Road", "Baker Str 2216", "Russell Street, WC1B 3DG", "Bankside, SE1 9TG", "Threadneedle Street, EC2R 8AH"],
        .City: ["New York", "Los Angeles", "Pittsburg", "London", "Paris", "Mexico"],
        .State: ["NY", "CO", "Idaho", "Iowa", "WY", "WA", "AR", "HI", "DE", "IL"],
        .ZipCode: ["400005", "19712", "12555", "17600", "24007", "33465", "55301"],
        .DateOfBirth: ["12/06/1973", "02/07/1999", "13/08/1982", "01/03/2003", "25/04/1969", "15/02/1980"],
        .DateOfVisit: ["10/10/2016", "05/05/2016", "13/11/2016", "12/11/2016", "05/04/2016"],
        .VendorCompany: ["Coca Cola", "Google", "Apple", "IBM", "NHL TV", "FedEx", "Qwintry Inc"],
        .ManagementTier: ["General Manager", "Regional CEO", "Assistant", "Sales Chief", "Tech Support Chief"],
        .SocialSecurityNumber: ["123-45-6789", "111-22-3333", "234-99-0073", "991-66-3455", "534-22-8972"],
        .ProjectNumber: ["1001", "1002", "1003", "2001", "2002", "9999", "6455", "2009", "1616"]
    ]
}
