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
    @IBOutlet var editButton: UIButton!
    @IBOutlet var closeButton: UIButton!

    var selectedIdx = 0
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

        foodImage.image = UIImage(named: foods[selectedIdx].pic)
        foodName.text = foods[selectedIdx].name
        detaildict = ["quantity": foods[selectedIdx].quantity.description,
                      "period": foods[selectedIdx].period]
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
