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
        return ["quantity", "period"]
    }
    static var editItems: [String] {
        return ["quantity", "period", "classified"]
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
    
    var selectedIdx = 0 //decide the index data for show
    var titleArray = TableItemIdx.dispItems
    var valueArray = [Any]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        isEditMode = false
        nameTextField.text = foods[selectedIdx].name
        nameTextField.delegate = self
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
            textFieldLowestPoint = detailTableView.frame.origin.y+50
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
            foodImage.image = UIImage(named: foods[selectedIdx].pic)
        case .tabledata:
            valueArray = [foods[selectedIdx].quantity.description, foods[selectedIdx].period, foods[selectedIdx].classified]
//        default:
        }
    }

    //MARK: - Button events
    @IBAction func editButtonClicked(_ sender: Any) {
        isEditMode = true
        detailTableView.reloadData()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        isEditMode = false
        detailTableView.reloadData()
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
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isEditMode {
            switch indexPath.row {
            case TableItemIdx.quantity.rawValue:
                let cell = tableView.dequeueReusableCell(withIdentifier: "inputcell", for: indexPath) as! InputViewCell
                cell.title.text = titleArray[indexPath.row]
                cell.input.text = String(describing: valueArray[indexPath.row])
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "buttoncell", for: indexPath) as! ButtonViewCell
                cell.title.text = titleArray[indexPath.row]
                cell.dateButton.setTitle(String(describing: valueArray[indexPath.row]), for: .normal)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "fooditemcell", for: indexPath) as! FoodItemViewCell
            cell.title.text = titleArray[indexPath.row]
            cell.content.text = String(describing: valueArray[indexPath.row])
            return cell
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

extension ItemViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
