//
//  LapTableViewCell.swift
//  Stopwatch
//
//  Created by Vittorio Morganti on 22/01/16.
//  Copyright © 2016 toioski. All rights reserved.
//

import UIKit

class LapTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        label.font = UIFont.monospacedDigitSystemFontOfSize(17, weight: UIFontWeightRegular)
        time.font = UIFont.monospacedDigitSystemFontOfSize(17, weight: UIFontWeightRegular)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
