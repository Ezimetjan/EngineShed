//
//  DecoderType+Stock.swift
//  EngineShed
//
//  Created by Scott James Remnant on 3/5/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import Foundation

extension DecoderType {

    /// Update the `remainingStock` field.
    func updateRemainingStock() {
        guard let decoders = decoders as? Set<Decoder> else { return }
        let remainingStock = decoders.filter({ $0.isUnallocated }).count
        if self.remainingStock != remainingStock {
            self.remainingStock = Int16(truncatingIfNeeded: remainingStock)
        }
    }

}
