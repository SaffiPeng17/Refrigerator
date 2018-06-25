//
//  ItemViewCell.swift
//  Refrigerator
//
//  Created by Saffi on 18/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit


protocol ItemViewCellDelegate {
    func buttonClicked()
}

class ItemViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var content: UILabel!
    @IBOutlet var button: UIButton!
    
    var delegate: ItemViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonClicked(_ sender: Any) {
        delegate?.buttonClicked()
    }
}
