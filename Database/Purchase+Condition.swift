//
//  Purchase+Condition.swift
//  EngineShed
//
//  Created by Scott James Remnant on 12/12/17.
//  Copyright © 2017 Scott James Remnant. All rights reserved.
//

import Foundation

public enum PurchaseCondition : Int16, CaseIterable {

    case new = 1
    case likeNew
    case used
    case usedInWrongBox
    case handmade
    
}

extension PurchaseCondition : CustomStringConvertible, ConvertibleFromString {
    
    public var description: String {
        switch self {
        case .new: return "New"
        case .likeNew: return "Like New"
        case .used: return "Used"
        case .usedInWrongBox: return "Used in Wrong Box"
        case .handmade: return "Handmade"
        }
    }
    
}

extension Purchase {

    public var condition: PurchaseCondition? {
        get { return PurchaseCondition(rawValue: conditionRawValue) }
        set { conditionRawValue = newValue?.rawValue ?? 0 }
    }

}