//
//  addProductViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/1.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class addProductViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    

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
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        picImage.contentMode = .scaleAspectFit
        picImage.image = image
        dismiss(animated: true, completion: nil)
    }

}

