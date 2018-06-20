//
//  DateViewCell.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class DateViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet weak var dateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
