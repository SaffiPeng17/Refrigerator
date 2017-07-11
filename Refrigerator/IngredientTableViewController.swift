//
//  IngredientTableViewController.swift
//  Refrigerator
//
//  Created by Saffi on 10/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit

class IngredientTableViewController: UITableViewController {
    
    //Models
    var foods = ["Onion", "Watermelon", "Banana", "Grapefruit", "Pumpkin",
                 "Potato", "Carrot", "Cabbage", "Cucumber", "Pea",
                 "Chicken", "Beef", "Cheese", "Butter", "Ham",
                 "Sausage", "Milk", "Black Tea", "Curry", "Spaghetti", "Juice"]
    
    var foodimgs = ["onion.jpg", "watermelon.jpg", "banana.jpg", "grapefruit.jpg", "pumpkin.jpg",
                    "potato.jpg", "carrot.jpg", "cabbage.jpg", "cucumber.jpg", "pea.jpg",
                    "chicken.jpg", "beef.jpg", "cheese.jpg", "butter.jpg", "ham.jpg",
                    "sausage.jpg", "milk.jpg", "blacktea.jpg", "curry.jpg", "spaghetti.jpg", "juice.jpg"]
    
    var foodSelect = Array(repeating: false, count: 21)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientTableViewCell
        //Setup cell
        cell.foodName.text = foods[indexPath.row]
        cell.foodImage.image = UIImage(named: foodimgs[indexPath.row])
        cell.accessoryType = foodSelect[indexPath.row] ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "What do you want?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let selectTitle = foodSelect[indexPath.row] ? "de-Select" : "Select"
        let selectAction = UIAlertAction(title: selectTitle, style: .default) { (action: UIAlertAction) in
            let cell = tableView.cellForRow(at: indexPath)
            self.foodSelect[indexPath.row] = !self.foodSelect[indexPath.row]
            cell?.accessoryType = self.foodSelect[indexPath.row] ? .checkmark : .none
        }
        optionMenu.addAction(selectAction)
        
        let callAction = UIAlertAction(title: "Call 12345678", style: .default) { (action: UIAlertAction) in
            let alert = UIAlertController(title: "Service Unavailable", message: "Sorry, ther call feature is not available yet. Please retry later.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        optionMenu.addAction(callAction)
        present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
