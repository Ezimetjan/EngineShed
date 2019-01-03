//
//  TrainAddMemberCell.swift
//  EngineShed iOS
//
//  Created by Scott James Remnant on 1/1/19.
//  Copyright © 2019 Scott James Remnant. All rights reserved.
//

import UIKit

import Database

class TrainAddMemberCell : UITableViewCell {

    @IBOutlet weak var label: UILabel!

    var train: Train? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        guard let train = train else { return }
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        label.textColor = label.tintColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}