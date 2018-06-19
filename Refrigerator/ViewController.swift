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
            if let shareImage = UIImage(named: foods[indexPath.row].pic) {
                let shareText = foods[indexPath.row].name
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
                foods.remove(at: indexPath.row)
//                self.foodimgs.remove(at: indexPath.row)
                foodSelect.remove(at: indexPath.row)
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
                destController.selectedIdx = idxPath.row
            }
        }
    }

}
