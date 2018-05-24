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

    var foodImgRef = ""
    var foodNameRef = ""
    var detaildict = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImage.image = UIImage(named: foodImgRef)
        foodName.text = foodNameRef
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
