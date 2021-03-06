//
//  ItemViewController.swift
//  Refrigerator
//
//  Created by Saffi on 18/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit


enum FoodDataType {
    case image
    case tabledata
}

enum TableItemIdx: Int {
    case quantity = 0
    case vailddate
    case classified
    
    static var dispItems: [String] {
        return ["quantity", "valid date"]
    }
    static var editItems: [String] {
        return ["quantity", "valid date", "classified"]
    }
}

class ItemViewController: UIViewController {

    @IBOutlet var foodImage: UIImageView! {
        didSet {
            fetchFoodData(dataType: .image)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var detailTableView: UITableView! {
        didSet {
            fetchFoodData(dataType: .tabledata)
        }
    }
    @IBOutlet var editButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    //DialogView
    @IBOutlet weak var dialogSuperView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dialogTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var classifiedPicker: UIPickerView!
    @IBOutlet weak var classifiedTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var fooddata: Record?
    var cellSelectedIdx = 0
    var classifiedSelectedIdx = 0
    var titleArray = TableItemIdx.dispItems
    var valueArray = [String]()
    var attribureEditMode = false
    var isEditMode: Bool! {
        didSet {
            titleArray = isEditMode ? TableItemIdx.editItems : TableItemIdx.dispItems

            nameTextField.isEnabled = isEditMode
            nameTextField.textColor = isEditMode ? UIColor.editYellow : UIColor.white
            editButton.isHidden = isEditMode
            editButton.isEnabled = !isEditMode
            
            closeButton.isHidden = !isEditMode
            closeButton.isEnabled = isEditMode
            cameraButton.isHidden = !isEditMode
            cameraButton.isEnabled = isEditMode
            galleryButton.isHidden = !isEditMode
            galleryButton.isEnabled = isEditMode
        }
    }
    var viewShiftY: (name: CGFloat?, quantity: CGFloat?)
    var isNewClassified = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isEditMode = attribureEditMode

        nameTextField.text = fooddata?.name
        nameTextField.delegate = self
        
        dialogView.layer.cornerRadius = 15
        doneButton.layer.cornerRadius = 15
        //Add notification
        addNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //點一下Keyboard以外的地方，會收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyKeyboardChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func notifyKeyboardChangeFrame(notification: NSNotification) {
        //Get the height of Keyboard
        let info = notification.userInfo!
        let keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        var keyboardY = keyboardFrame.minY
        //7 為 view 調整位置之後，TextField 與 Keyboard 的間距
        var textFieldLowestPoint = CGFloat(0.0)
        
        view.frame.origin.y = 0
        if nameTextField.isFirstResponder {
            keyboardY = keyboardY-7
            textFieldLowestPoint = detailTableView.frame.origin.y
            if textFieldLowestPoint > keyboardY {
                if viewShiftY.name == nil {
                    view.frame.origin.y = view.frame.origin.y-abs(textFieldLowestPoint-keyboardY)
                    viewShiftY.name = view.frame.origin.y
                } else {
                    view.frame.origin.y = viewShiftY.name!
                }
            }
        } else {
            keyboardY = keyboardY-30
            textFieldLowestPoint = detailTableView.frame.origin.y+30
            if textFieldLowestPoint > keyboardY {
                if viewShiftY.quantity == nil {
                    view.frame.origin.y = view.frame.origin.y-abs(textFieldLowestPoint-keyboardY)
                    viewShiftY.quantity = view.frame.origin.y
                } else {
                    view.frame.origin.y = viewShiftY.quantity!
                }
            }
        }
    }
    
    //MARK: - Table data
    func fetchFoodData(dataType: FoodDataType) {
        switch dataType {
        case .image:
            foodImage.image = (fooddata != nil) ? UIImage(data: (fooddata?.image!)!) : nil
        case .tabledata:
            if fooddata != nil {
                valueArray = [String(describing: fooddata!.quantity),
                              fooddata!.validdate!,
                              fooddata!.classified!]
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.string(from: Date())
                valueArray = ["0", date, classifiedArray[0]]
            }
        }
    }

    //MARK: - Verify data before save
    func verifyChanged() -> (result: Bool, message: String) {
        var isVerifySuccess = true
        var message = ""
        //verify: Name
        if nameTextField.text == nil || nameTextField.text == "" {
            isVerifySuccess = false
            message = VerifyError.veNameEmpty.message
        } else {
            //verify: Quantity
            let quantity = self.valueArray[TableItemIdx.quantity.rawValue]
            if Int(quantity) == 0 {
                isVerifySuccess = false
                message = VerifyError.veQuantityZero.message
            } else {
                //verify: Valid Date
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.date(from: valueArray[TableItemIdx.vailddate.rawValue])!
                if date <= Date() {
                    isVerifySuccess = false
                    message = VerifyError.veValidDateError.message
                }
            }
        }
        return (isVerifySuccess, message)
    }

    //MARK: - Button events
    @IBAction func editButtonClicked(_ sender: Any) {
        isEditMode = true
        detailTableView.reloadData()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        let message = "Are you sure to save the changes?"
        let alert = UIAlertController(title: "Notification", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            let verifyResult = self.verifyChanged()
            if verifyResult.result {
                //Prepare Record data for saving
                let record = RecordData()
                record.name = self.nameTextField.text!
                record.quantity = Int(self.valueArray[TableItemIdx.quantity.rawValue])!
                record.validdate = self.valueArray[TableItemIdx.vailddate.rawValue]
                record.classified = self.valueArray[TableItemIdx.classified.rawValue]
                if self.foodImage.image != nil {
                    let tmpImage = UIImage(cgImage: self.foodImage.image!.cgImage!, scale: self.foodImage.image!.scale, orientation: .up)
                    record.image = UIImagePNGRepresentation(tmpImage)
                } else {
                    record.image = nil
                }
                //Update Core Data
                let predicate = NSPredicate(format: "name == %@", record.name)
                let isUpdateSuccess = (self.fooddata == nil) ? Coredata.shared.createNewRecords(record: record) : Coredata.shared.updateRecord(predicate: predicate, updateValues: record)
                if isUpdateSuccess { //Create new record
                    self.isEditMode = false
                    self.detailTableView.reloadData()
                    isReloadListTable = true
                }
            } else {
                let alert = UIAlertController(title: "Notification", message: verifyResult.message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { _ in
            self.isEditMode = false
            self.fetchFoodData(dataType: .tabledata)
            self.detailTableView.reloadData()
        }))
        present(alert, animated: true)
    }

    @IBAction func galleryButtonClicked(_ sender: Any) {
        //開啟Gallery前，要先確認是否可以使用Gallery
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notification", message: "Gallery is not available!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButtonClicked(_ sender: Any) {
        //開啟Camera前，要先確認是否可以使用Camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Notification", message: "Camera is not available!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func diaCloseButtonClicked(_ sender: Any) {
        dialogSuperView.isHidden = true
    }
    
    @IBAction func diaDoneButtonClicked(_ sender: Any) {
        dialogSuperView.isHidden = true
        
        switch cellSelectedIdx {
        case TableItemIdx.vailddate.rawValue:
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            valueArray[cellSelectedIdx] = formatter.string(from: datePicker.date)
        case TableItemIdx.classified.rawValue:
            if isNewClassified {
                if classifiedTextField.text != nil || classifiedTextField.text != "" {
                    let _ = Coredata.shared.createNewClassified(classified: classifiedTextField.text!)
                    valueArray[cellSelectedIdx] = classifiedTextField.text!
                }
            } else {
                valueArray[cellSelectedIdx] = classifiedArray[classifiedSelectedIdx]
            }
        default:
            print("?? cellSelectedIdx = \(cellSelectedIdx)")
        }
        detailTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEditMode {
            switch indexPath.row {
            case TableItemIdx.quantity.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputcell", for: indexPath) as! InputViewCell
                cell.title.text = titleArray[indexPath.row]
                cell.input.text = valueArray[indexPath.row]
                cell.input.delegate = self
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemViewCell
                cell.title.text = titleArray[indexPath.row]
                cell.content.text = valueArray[indexPath.row]
                cell.content.textColor = UIColor.editBlue
                if indexPath.row == TableItemIdx.classified.rawValue {
                    cell.button.isHidden = false
                    cell.button.isEnabled = true
                    cell.delegate = self
                } else {
                    cell.button.isHidden = true
                    cell.button.isEnabled = false
                }
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath) as! ItemViewCell
            cell.title.text = titleArray[indexPath.row]
            cell.content.text = valueArray[indexPath.row]
            cell.content.textColor = UIColor.black
            cell.button.isHidden = true
            cell.button.isEnabled = false
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditMode {
            cellSelectedIdx = indexPath.row
            switch indexPath.row {
            case TableItemIdx.vailddate.rawValue:
                dialogSuperView.isHidden = false
                datePicker.isHidden = false
                datePicker.isEnabled = true
                classifiedPicker.isHidden = true
                classifiedTextField.isHidden = true
                classifiedTextField.isEnabled = false
                
                dialogTitle.text = "Pick A Date"
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let pickerDate = formatter.date(from: valueArray[indexPath.row])!
                datePicker.setDate(pickerDate, animated: true)

            case TableItemIdx.classified.rawValue:
                isNewClassified = false
                dialogSuperView.isHidden = false
                datePicker.isHidden = true
                datePicker.isEnabled = false
                classifiedPicker.isHidden = false
                classifiedTextField.isHidden = true
                classifiedTextField.isEnabled = false
                
                dialogTitle.text = "Pick A Classified"
                let currentClassified = valueArray[indexPath.row]
                for (idx, obj) in classifiedArray.enumerated() {
                    if obj == currentClassified {
                        classifiedSelectedIdx = idx
                        break
                    }
                }
                classifiedPicker.selectRow(classifiedSelectedIdx, inComponent: 0, animated: true)

            default:
                return
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        foodImage.image = image
        detailTableView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension ItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    //SETUP: How many kinds of option?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //SETUP: How many items of options?
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return classifiedArray.count
    }
    //SETUP: The content of every item.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classifiedArray[row]
    }
    //SETUP: Selected a row.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        classifiedSelectedIdx = row
    }
}

//MARK: - UITextFieldDelegate
extension ItemViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != nameTextField {
            valueArray[TableItemIdx.quantity.rawValue] = textField.text!
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ItemViewController: ItemViewCellDelegate {
    func buttonClicked() {
        isNewClassified = true
        dialogSuperView.isHidden = false
        datePicker.isHidden = true
        datePicker.isEnabled = false
        classifiedPicker.isHidden = true
        classifiedTextField.isHidden = false
        classifiedTextField.isEnabled = true

        dialogTitle.text = "Input New Classified"
        cellSelectedIdx = TableItemIdx.classified.rawValue
    }
}


