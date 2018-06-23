//
//  ViewController.swift
//  Refrigerator
//
//  Created by Saffi on 11/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit


var selectedIdx = 0

class ViewController: UIViewController {
    
    @IBOutlet weak var foodListTableView: UITableView!
    
    //Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFoodImage" {
            if let idxPath = foodListTableView.indexPathForSelectedRow {
                let destController = segue.destination as! ItemViewController
                let key = classifiedArray[idxPath.section]
                let data = foodDict[key]![idxPath.row]

                destController.fooddata = data
                destController.attribureEditMode = false
            }
        }
    }

    func prepareData() {
        let classified = Coredata.shared.readClassified(fetchLimit: nil, predicate: nil, sortBy: nil)
        print("How many classified? \(classified.count)")
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return classifiedArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(foodDict.keys)[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array(foodDict.values)[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath) as! ListViewCell
        if foodDict.count > 0 {
            let key = classifiedArray[indexPath.section]
            let data = foodDict[key]![indexPath.row]
            //Setup cell
            cell.fName.text = data.name
            cell.fImage.image = data.image
            cell.fQuantity.text = data.quantity?.description
            cell.fPeriod.text = data.vaildDate
    //        cell.accessoryType = foodSelect[indexPath.row] ? .checkmark : .none
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            foods.remove(at: indexPath.row)
//            foodSelect.remove(at: indexPath.row)
//        }
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
//            if let shareImage = UIImage(named: foods[indexPath.row].pic) {
//                let shareText = foods[indexPath.row].name
//                let activityCtrler = UIActivityViewController(activityItems: [shareText, shareImage], applicationActivities: nil)
//                self.present(activityCtrler, animated: true, completion: nil)
//            }
//        }
//        share.backgroundColor = UIColor(red: 26/255, green: 27/255, blue: 65/255, alpha: 1)
//
//        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
//            let alert = UIAlertController(title: "Confirm", message: "Are you sure to delete?", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(cancelAction)
//            let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
//                foods.remove(at: indexPath.row)
//                foodSelect.remove(at: indexPath.row)
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
//
//        }
//        delete.backgroundColor = UIColor(red: 192/255, green: 132/255, blue: 151/255, alpha: 1)
//
//        return [share, delete]
//    }
}
