//
//  NSLayoutConstraintExtension.swift
//  Stopwatch
//
//  ESSENTIAL EXTENSION FOR DEBUGGING NSCONTRAINT PROBLEMS
//
//  Created by Vittorio Morganti on 23/01/16.
//  Copyright © 2016 toioski. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
