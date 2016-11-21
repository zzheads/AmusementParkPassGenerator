//
//  Line.swift
//  AmusementParkPassGenerator
//
//  Created by Alexey Papin on 21.11.16.
//  Copyright © 2016 zzheads. All rights reserved.
//

import UIKit

class HorizontalLine: UIView {
    
    init(xStart: Int, xEnd: Int, y: Int, color: UIColor) {
        let rect = CGRect(x: xStart, y: y, width: xEnd - xStart, height: 1)
        super.init(frame: rect)
        self.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
