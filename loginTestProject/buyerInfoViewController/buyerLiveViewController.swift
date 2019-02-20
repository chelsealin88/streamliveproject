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
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func stepper(_ sender: UIStepper) {
        
        quantityLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func buyButton(_ sender: Any) {
        
    }
    
    func reloadProduct(_ timer: inout Timer?, _ viewController: UIViewController, _ timeInterval: TimeInterval) {
        
        timer = Timer.init(timeInterval: timeInterval, target: viewController, selector: #selector(buyerGetItem), userInfo: nil, repeats: true)

    }
    
    func buyerGetItem() {
        
        getStreamItem.getStreamItems("/streaming-items", header) { (streamItemData, statusCode) in
            self.nameLabel.text = streamItemData.name
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
