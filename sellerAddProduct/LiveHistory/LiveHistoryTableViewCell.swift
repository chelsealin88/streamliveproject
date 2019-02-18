//
//  LiveHistoryTableViewCell.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/2/18.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import UIKit

class LiveHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var iFrame: UILabel!
    @IBOutlet weak var channelDescription: UIStackView!
    @IBOutlet weak var Ended: UILabel!
    @IBOutlet weak var started: UILabel!
    @IBOutlet weak var iFrameLabel: UILabel!
    @IBOutlet weak var cdLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
