//
//  DialogViewController.swift
//  Refrigerator
//
//  Created by Xinhui Peng on 2018/6/21.
//  Copyright © 2018 Saffi. All rights reserved.
//

import UIKit


//protocol DialogDelegate {
//    func doneButtonTouched(date: Date)
//}

enum PickerType {
    case date
    case classified
}

class DialogViewController: UIViewController {
    
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dialogTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var classifiedPicker: UIPickerView!
    @IBOutlet weak var doneButton: UIButton! {
        didSet {
            doneButton.backgroundColor = UIColor.editYellow
//            doneButton.layer.borderWidth = 1
//            doneButton.layer.borderColor = UIColor.black.cgColor
            doneButton.layer.cornerRadius = 15
        }
    }
    
    var pickerType: PickerType = .date
    var selectedIdx = 0
    var currentDate = Date()
//    var dialogDelegate: DialogDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dialogView.layer.cornerRadius = 15
        
        switch pickerType {
        case .date:
            datePicker.isHidden = false
            datePicker.isEnabled = true
            classifiedPicker.isHidden = true
            
            datePicker.setDate(currentDate, animated: true)
            datePicker.minimumDate = currentDate
            
        case .classified:
            datePicker.isHidden = true
            datePicker.isEnabled = false
            classifiedPicker.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func doneButtonClicked(_ sender: Any) {
//        //Setting date
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//
//        //Switch View
//        let ctrler = ItemViewController()
//        ctrler.isEditMode = true
//        ctrler.valueArray[1] = formatter.string(from: datePicker.date)
//        ctrler.detailTableView.reloadData()
//        present(ctrler, animated: true, completion: nil)
////        dialogDelegate?.doneButtonTouched(date: picker.date)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destController = segue.destination as! ItemViewController
        destController.selectedIdx = selectedIdx
        destController.attribureEditMode = true
        
        if segue.identifier == "settingDone" {
            destController.setDate = datePicker.date
        }
    }

}
