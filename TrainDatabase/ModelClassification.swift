//
//  ModelClassification.swift
//  TrainDatabase
//
//  Created by Scott James Remnant on 12/12/17.
//  Copyright © 2017 Scott James Remnant. All rights reserved.
//

import Foundation
import CoreData

enum ModelClassification : Int16, Codable {

    case locomotive = 1
    case coach
    case wagon
    case multipleUnit
    case departmental
    case maintenance
    case accessory
    
}

extension ModelClassification : EnumeratableEnum, CustomStringConvertible, ConvertibleFromString {
    
    static let all: [ModelClassification] = [ .locomotive, .coach,. wagon, .multipleUnit, .departmental, .maintenance, .accessory ]

    var description: String {
        switch self {
        case .locomotive:
            return "Locomotive"
        case .coach:
            return "Coach"
        case .wagon:
            return "Wagon"
        case .multipleUnit:
            return "Multiple Unit"
        case .departmental:
            return "Departmental"
        case .maintenance:
            return "Maintenance"
        case .accessory:
            return "Accessory"
        }
    }
    
}
