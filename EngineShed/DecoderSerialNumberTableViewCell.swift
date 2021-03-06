//
//  DecoderSerialNumberTableViewCell.swift
//  EngineShed
//
//  Created by Scott James Remnant on 3/8/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import UIKit

import Database

class DecoderSerialNumberTableViewCell : UITableViewCell {

    @IBOutlet weak var serialNumberLabel: UILabel!

    var decoder: Decoder? {
        didSet {
            configureView()
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

    func configureView() {
        serialNumberLabel.text = decoder?.serialNumber
    }

}
