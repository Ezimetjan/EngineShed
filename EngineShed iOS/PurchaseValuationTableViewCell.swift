//
//  PurchaseValuationTableViewCell.swift
//  EngineShed iOS
//
//  Created by Scott James Remnant on 1/6/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import UIKit

import Database

class PurchaseValuationTableViewCell : UITableViewCell, PurchaseSettable {

    @IBOutlet weak var valuationLabel: UILabel!

    var purchase: Purchase? {
        didSet {
            configureCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell() {
        valuationLabel.text = purchase?.valuationAsString
    }

}
