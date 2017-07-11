//
//  IngredientTableViewCell.swift
//  Refrigerator
//
//  Created by Saffi on 11/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var foodQuantity: UILabel!
    @IBOutlet var foodPeriod: UILabel!
    
    @IBOutlet weak var nImage: UIImageView!
    @IBOutlet weak var nName: UILabel!
    @IBOutlet weak var nQuantity: UILabel!
    @IBOutlet weak var nPeriod: UILabel!
    
    @IBOutlet weak var fImage: UIImageView!
    @IBOutlet weak var fName: UILabel!
    @IBOutlet weak var fQuantity: UILabel!
    @IBOutlet weak var fPeriod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
