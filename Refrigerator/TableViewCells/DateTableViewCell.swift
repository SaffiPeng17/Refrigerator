//
//  DateTableViewCell.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var datepicker: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
