//
//  buyerLiveViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/19.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit
import SwiftyJSON

class buyerLiveViewController: UIViewController {
    
    var pickerView = UIPickerView()
    var streamStatus = Bool()
    var timer: Timer?
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header
    var address = [(id: Int, name: String)]()
    var recipientID = Int()
    var itemID = Int()
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rqLabel: UILabel!
    @IBOutlet weak var sqLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var buyerAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Leave", style: .bordered, target: self, action: #selector(back(_:)) )
        self.navigationItem.leftBarButtonItem = backButton
        self.buyerAddressTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadProduct(&self.timer, self, 3)
        self.getAddress { (callBack) in
            self.address = callBack
            self.setDoneButton([self.buyerAddressTextField])
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        recipientID = Int()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        
        quantityLabel.text = "\(Int(sender.value))"
        
    }
    
    @IBAction func buyButton(_ sender: Any) {
        
        var itemid = self.itemID
        var recipientId: Int
        guard let quantityText = quantityLabel.text else { return }
        guard let number = Int(quantityText) else { return }
        
        
        let body : [String : Any] = ["number" : number]
        
        PlaceOrder.placeOrders(itemid, self.recipientID, header, body) { (result) in
            
            print(result)
        }
    }

    
    
    func reloadProduct(_ timer: inout Timer?, _ viewController: UIViewController, _ timeInterval: TimeInterval) {
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: viewController, selector: #selector(buyerGetItem), userInfo: nil, repeats: true)
        
    }
    
    @objc func back(_ sender : UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Are you sure to leave this stream ?", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Yesss", style: .default) { (actionAlert) in
            
            Request.putAPI(api: "/user-channel-id", header: self.header, { (statusCode, data) in
                
                if statusCode == 200 {
                    
                    DispatchQueue.main.async {
                        self.streamStatus = false
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                    
                } else {
                    let json = try? JSON(data: data)
                }
                
            })
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func buyerGetItem() {
        
        getStreamItem.getStreamItems("/streaming-items", header) { (streamItemData, statusCode) in
            
            DispatchQueue.main.async {
                self.itemID = streamItemData.id
                self.nameLabel.text = streamItemData.name
                self.descriptionLabel.text = streamItemData.description
                self.priceLabel.text = "\(streamItemData.price)"
                self.rqLabel.text = "\(streamItemData.rq)"
                self.sqLabel.text = "\(streamItemData.sq)"
                self.image.image = streamItemData.image
            }
            
        }
        
    }
    
    func getAddress(callBack: @escaping ([(id: Int, name: String)]) -> Void) {
        
        Request.getAPI(api: "/recipients", header: header) { (data, statusCode) in
            
            var recipientArray = [(id: Int, name: String)]()
            
            if statusCode == 200 {
                do {
                    let json = try JSON(data: data)
                    guard let response = json["response"].array else { return }
                    for recipient in response {
                        guard let id = recipient["recipient_id"].int else { return }
                        guard let name = recipient["name"].string else { return }
                        
                        recipientArray.append((id: id, name: name))
                    }
                    callBack(recipientArray)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

extension buyerLiveViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return address.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return address[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.recipientID = address[row].id
        self.buyerAddressTextField.text = address[row].name

    }
    
    func setDoneButton(_ textFieldArray: [UITextField]){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpeace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClick))
        toolBar.setItems([flexibleSpeace, doneButton], animated: false)
        
        for textField in textFieldArray {
            textField.inputAccessoryView = toolBar
        }
    }
    
    @objc func doneClick(){
        view.endEditing(true)
    }

}
