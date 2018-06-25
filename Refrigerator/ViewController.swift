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
    
    @IBOutlet weak var foodListTableView: UITableView! {
        didSet {
            prepareData()
        }
    }
    
    //Funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isReloadListTable {
            foodListTableView.reloadData()
            isReloadListTable = false
        }
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let idxPath = foodListTableView.indexPathForSelectedRow {
                let destController = segue.destination as! ItemViewController
                let key = Array(foodDict.keys)[idxPath.section]
                let data = (foodDict.count > 0) ? foodDict[key]![idxPath.row] : nil

                destController.fooddata = data
                destController.attribureEditMode = false
            }
        } else if segue.identifier == "showFoodEdit" {
            let destController = segue.destination as! ItemViewController
            destController.fooddata = nil
            destController.attribureEditMode = true
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //SETUP: How many sections in Table?
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodDict.count//classifiedArray.count
    }
    //SETUP: What is the header of every sections?
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (foodDict.count) > 0 else {
            return nil
        }
        return Array(foodDict.keys)[section]
    }
    //SETUP: How many rows in every section?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard foodDict.count > 0 else {
            return 0
        }
        return Array(foodDict.values)[section].count
    }
    //SETUP: The view of every cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath) as! ListViewCell
        if foodDict.count > 0 {
            let key = Array(foodDict.keys)[indexPath.section]
            let data = foodDict[key]![indexPath.row]
            //Setup cell
            cell.fName.text = data.name
            cell.fImage.image = UIImage(data: data.image!)
            cell.fQuantity.text = data.quantity.description
            cell.fPeriod.text = data.validdate
        }
        return cell
    }
    //SETUP: Can the rows be edited?
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //SETUP: Define the type of Edit.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = Array(foodDict.keys)[indexPath.section]
            let data = foodDict[key]![indexPath.row]
            let message = "Are you sure to delete \(data.name!)?"
            let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                let predicate = NSPredicate(format: "name == %@", data.name!)
                let _ = Coredata.shared.deleteRecords(predicate: predicate)
                self.foodListTableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
