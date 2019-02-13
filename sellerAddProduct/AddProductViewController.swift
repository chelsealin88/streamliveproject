//
//  addProductViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/1.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddProductViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

    @IBOutlet weak var ProductName: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var ProductCost: UILabel!
    
    @IBOutlet weak var picImage: UIImageView!
    
    @IBOutlet weak var ProductPrice: UILabel!
    
    @IBOutlet weak var Stock: UILabel!
    
    @IBOutlet weak var NameTextField: UITextField!
    
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    @IBOutlet weak var CostTextField: UITextField!
    
    @IBOutlet weak var PriceTextField: UITextField!
    
    @IBOutlet weak var StockTextField: UITextField!
    
    @IBAction func SaveItemButton(_ sender: Any) {
        
        SaveItems.uploadProduct(picImage.image!, NameTextField.text!, DescriptionTextField.text!, CostTextField.text!, PriceTextField.text!, StockTextField.text!) { (data) in
            
            do {
                let json = try JSON(data: data)
                print(json)
                guard let result = json["result"].bool else { return }
                guard let response = json["response"].string else { return }
                
                print(result)
                print(response)
                
            } catch {
                print(error.localizedDescription)
            }
           
           
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                print("button used")
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                show(imagePicker, sender: self)
            } else {
                print("fail")
            }
//
//            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
//
//            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
//                if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                    let imagePicker = UIImagePickerController()
//                    imagePicker.allowsEditing = false
//                    imagePicker.sourceType = .camera
//
//                    self.present(imagePicker, animated: true, completion: nil)
//            }
//
//        }
//
//            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
//
//                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//                    let imagePicker = UIImagePickerController()
//                    imagePicker.allowsEditing = false
//                    imagePicker.sourceType = .photoLibrary
//
//                    self.present(imagePicker, animated: true, completion: nil)
//
//            }
//
//        }
//
//            photoSourceRequestController.addAction(cameraAction)
//            photoSourceRequestController.addAction(photoLibraryAction)
//
//        }
//
//
            
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        picImage.contentMode = .scaleAspectFit
        picImage.image = image
        dismiss(animated: true, completion: nil)
    }

}


