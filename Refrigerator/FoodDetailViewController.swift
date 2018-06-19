//
//  FoodDetailViewController.swift
//  Refrigerator
//
//  Created by Saffi on 18/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit

class FoodDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var foodImgRef = ""
    var foodNameRef = ""
    var detaildict = [String: String]()
    var isEditMode: Bool! {
        didSet {
            closeButton.isHidden = !isEditMode
            closeButton.isEnabled = isEditMode
            editButton.isHidden = isEditMode
            editButton.isEnabled = !isEditMode
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImage.image = UIImage(named: foodImgRef)
        foodName.text = foodNameRef
        isEditMode = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Button events
    @IBAction func editButtonClicked(_ sender: Any) {
        isEditMode = true
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        isEditMode = false
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detaildict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! FoodDetailTableViewCell
        
        for (index, dict) in detaildict.enumerated() {
            if index == indexPath.row {
                cell.title.text = dict.key
                cell.content.text = dict.value
            }
        }
        return cell
    }
}
