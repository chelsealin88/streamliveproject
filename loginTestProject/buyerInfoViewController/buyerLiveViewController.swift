//
//  buyerLiveViewController.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/19.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class buyerLiveViewController: UIViewController {
    
    let header = Header.init(token: UserDefaults.standard.value(forKey: UserDefaultKey.token.rawValue) as! String).header
    
    var timer: Timer?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rqLabel: UILabel!
    @IBOutlet weak var sqLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        let leaveButton = UIBarButtonItem(title: "Leave", style: UIBarButtonItem, target: self, action: #selector(leaveButton())
//        self.navigationItem.leftBarButtonItem = leaveButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadProduct(&self.timer, self, 3)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction func stepper(_ sender: UIStepper) {
        
        quantityLabel.text = "\(Int(sender.value))"
        
    }
    
    @IBAction func buyButton(_ sender: Any) {
        
    }
    
    func reloadProduct(_ timer: inout Timer?, _ viewController: UIViewController, _ timeInterval: TimeInterval) {
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: viewController, selector: #selector(buyerGetItem), userInfo: nil, repeats: true)

    }
    
//    @objc func leaveButton(_ sender : UIBarButtonItem) {
//
//        self.navigationController?.popViewController(animated: true)
//    }
//
    @objc func buyerGetItem() {
        
        getStreamItem.getStreamItems("/streaming-items", header) { (streamItemData, statusCode) in
            
            DispatchQueue.main.async {
                self.nameLabel.text = streamItemData.name
                self.descriptionLabel.text = streamItemData.description
                self.priceLabel.text = "\(streamItemData.price)"
                self.rqLabel.text = "\(streamItemData.rq)"
                self.sqLabel.text = "\(streamItemData.sq)"
                self.image.image = streamItemData.image
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
