//
//  DecoderType+Stock.swift
//  EngineShed
//
//  Created by Scott James Remnant on 3/5/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import Foundation

import Database

extension DecoderType {

    /// Returns `true` if `remainingStock` falls below `minimumStock`
    var isStockLow: Bool { minimumStock > 0 && remainingStock < minimumStock }

    /// Update the `remainingStock` field.
    func updateRemainingStock() {
        guard let decoders = decoders as? Set<Decoder> else { return }
        let remainingStock = decoders.count(where: { $0.isUnallocated })
        if self.remainingStock != remainingStock {
            self.remainingStock = Int16(truncatingIfNeeded: remainingStock)
        }
    }

}
