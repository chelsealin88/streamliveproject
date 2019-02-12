//
//  OrderTableViewCell.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/11.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var CostLabel: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    
    @IBOutlet weak var StockLabel: UILabel!
    
    @IBOutlet weak var CostNumber: UILabel!
    
    @IBOutlet weak var PriceNumber: UILabel!
    
    @IBOutlet weak var StockNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
