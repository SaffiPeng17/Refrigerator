//
//  ButtonViewCell.swift
//  Refrigerator
//
//  Created by Xinhui Peng on 2018/6/22.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit


protocol ButtonCellDelegate {
    func buttonCliced(info: (title: String, button: String))
}

class ButtonViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var buttonCellDelegate: ButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonClicked(_ sender: Any) {
        buttonCellDelegate?.buttonCliced(info: (title: title.text!, button: button.currentTitle!))
    }
}
