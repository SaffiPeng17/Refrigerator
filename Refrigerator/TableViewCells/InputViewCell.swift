//
//  InputViewCell.swift
//  Refrigerator
//
//  Created by Saffi on 2018/6/14.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit

class InputViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var input: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        input.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension InputViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
