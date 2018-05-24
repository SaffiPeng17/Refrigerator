//
//  ViewController.swift
//  Refrigerator
//
//  Created by Saffi on 11/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    //Models
    var foods: [Foods] = [
        Foods(name: "Onion", period: "2017-8-20", quantity: 3, pic: "onion.jpg"),
        Foods(name: "Watermelon", period: "2017-7-31", quantity: 1, pic: "watermelon.jpg"),
        Foods(name: "Banana", period: "2017-7-28", quantity: 10, pic: "banana.jpg"),
        Foods(name: "Grapefruit", period: "2017-7-16", quantity: 2, pic: "grapefruit.jpg"),
        Foods(name: "Pumpkin", period: "2017-8-7", quantity: 1, pic: "pumpkin.jpg"),
        
        Foods(name: "Potato", period: "2017-8-2", quantity: 5, pic: "potato.jpg"),
        Foods(name: "Carrot", period: "2017-8-16", quantity: 3, pic: "carrot.jpg"),
        Foods(name: "Cabbage", period: "2017-8-1", quantity: 1, pic: "cabbage.jpg"),
        Foods(name: "Cucumber", period: "2017-8-3", quantity: 3, pic: "cucumber.jpg"),
        Foods(name: "Pea", period: "2017-8-1", quantity: 1, pic: "pea.jpg"),
        
        Foods(name: "Chicken", period: "2017-7-29", quantity: 1, pic: "chicken.jpg"),
        Foods(name: "Beef", period: "2017-7-30", quantity: 3, pic: "beef.jpg"),
        Foods(name: "Cheese", period: "2017-8-20", quantity: 3, pic: "cheese.jpg"),
        Foods(name: "Butter", period: "2017-8-19", quantity: 1, pic: "butter.jpg"),
        Foods(name: "Ham", period: "2017-8-15", quantity: 7, pic: "ham.jpg"),
        
        Foods(name: "Sausage", period: "2017-7-29", quantity: 5, pic: "sausage.jpg"),
        Foods(name: "Milk", period: "2017-7-30", quantity: 1, pic: "milk.jpg"),
        Foods(name: "Black Tea", period: "2017-8-20", quantity: 10, pic: "blacktea.jpg"),
        Foods(name: "Curry", period: "2017-8-19", quantity: 1, pic: "curry.jpg"),
        Foods(name: "Spaghetti", period: "2017-8-15", quantity: 2, pic: "spaghetti.jpg"),
        
        Foods(name: "Juice", period: "2017-8-12", quantity: 1, pic: "juice.jpg")
    ]
    
//    var foods = ["Onion", "Watermelon", "Banana", "Grapefruit", "Pumpkin",
//                 "Potato", "Carrot", "Cabbage", "Cucumber", "Pea",
//                 "Chicken", "Beef", "Cheese", "Butter", "Ham",
//                 "Sausage", "Milk", "Black Tea", "Curry", "Spaghetti", "Juice"]
//    
//    var foodimgs = ["onion.jpg", "watermelon.jpg", "banana.jpg", "grapefruit.jpg", "pumpkin.jpg",
//                    "potato.jpg", "carrot.jpg", "cabbage.jpg", "cucumber.jpg", "pea.jpg",
//                    "chicken.jpg", "beef.jpg", "cheese.jpg", "butter.jpg", "ham.jpg",
//                    "sausage.jpg", "milk.jpg", "blacktea.jpg", "curry.jpg", "spaghetti.jpg", "juice.jpg"]
//    
    var foodSelect = Array(repeating: false, count: 21)
//
//    var quantity = ["3", "0.5", "6", "3", "1",
//                    "2", "2", "1", "4", "7",
//                    "0.75", "2", "3", "1", "6",
//                    "9", "1.5", "1", "3", "3", "10"]
//    
//    var period = ["2017/8/30", "2017/10/2", "", "", "",
//                  "2017/7/23", "2017/8/30", "", "2017/8/2", "2017/10/2",
//                  "2017/7/30", "2017/7/24", "2017/12/19", "2018/2/20", "2017/10/30",
//                  "2017/10/17", "2017/7/28", "2017/7/10", "", "", "2017/9/2"]
    
    //Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! IngredientTableViewCell
        //Setup cell
        cell.fName.text = foods[indexPath.row].name
        cell.fImage.image = UIImage(named: foods[indexPath.row].pic)
        cell.fQuantity.text = foods[indexPath.row].quantity.description
        cell.fPeriod.text = foods[indexPath.row].period
        cell.accessoryType = foodSelect[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let optionMenu = UIAlertController(title: nil, message: "What do you want?", preferredStyle: .actionSheet)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        optionMenu.addAction(cancelAction)
//        
//        let selectTitle = foodSelect[indexPath.row] ? "de-Select" : "Select"
//        let selectAction = UIAlertAction(title: selectTitle, style: .default) { (action: UIAlertAction) in
//            let cell = tableView.cellForRow(at: indexPath)
//            self.foodSelect[indexPath.row] = !self.foodSelect[indexPath.row]
//            cell?.accessoryType = self.foodSelect[indexPath.row] ? .checkmark : .none
//        }
//        optionMenu.addAction(selectAction)
//        
//        let callAction = UIAlertAction(title: "Delete Selected", style: .default) { (action: UIAlertAction) in
//            let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete?", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alert.addAction(cancelAction)
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
//        }
//        optionMenu.addAction(callAction)
//        present(optionMenu, animated: true, completion: nil)
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.remove(at: indexPath.row)
//            foodimgs.remove(at: indexPath.row)
            foodSelect.remove(at: indexPath.row)
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            if let shareImage = UIImage(named: self.foods[indexPath.row].pic) {
                let shareText = self.foods[indexPath.row].name
                let activityCtrler = UIActivityViewController(activityItems: [shareText, shareImage], applicationActivities: nil)
                self.present(activityCtrler, animated: true, completion: nil)
            }
        }
        share.backgroundColor = UIColor(red: 26/255, green: 27/255, blue: 65/255, alpha: 1)
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
                self.foods.remove(at: indexPath.row)
//                self.foodimgs.remove(at: indexPath.row)
                self.foodSelect.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        delete.backgroundColor = UIColor(red: 192/255, green: 132/255, blue: 151/255, alpha: 1)
        
        return [share, delete]
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodImage" {
            if let idxPath = myTableView.indexPathForSelectedRow {
                let destController = segue.destination as! FoodDetailViewController
                destController.foodImgRef = foods[idxPath.row].pic
                destController.foodNameRef = foods[idxPath.row].name
                destController.detaildict.updateValue(foods[idxPath.row].quantity.description, forKey: "quantity")
                destController.detaildict.updateValue(foods[idxPath.row].period, forKey: "period")
            }
        }
    }

}
