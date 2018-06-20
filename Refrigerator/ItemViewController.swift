//
//  ItemViewController.swift
//  Refrigerator
//
//  Created by Saffi on 18/07/2017.
//  Copyright © 2017 Saffi. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodName: UILabel!
    @IBOutlet var detailTableView: UITableView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    var selectedIdx = 0 //decide the index data for show
    var detaildict = [String: String]()
    var isEditMode: Bool! {
        didSet {
            editButton.isHidden = isEditMode
            editButton.isEnabled = !isEditMode
            //Editing state
            closeButton.isHidden = !isEditMode
            closeButton.isEnabled = isEditMode
            cameraButton.isHidden = !isEditMode
            cameraButton.isEnabled = isEditMode
            galleryButton.isHidden = !isEditMode
            galleryButton.isEnabled = isEditMode
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
//        detailTableView.reloadData()
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        isEditMode = false
//        detailTableView.reloadData()
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
