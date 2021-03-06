//
//  animation.swift
//  loginTestProject
//
//  Created by chelsea lin on 2019/1/29.
//  Copyright © 2019 chelsea lin. All rights reserved.
//

import Foundation
import NVActivityIndicatorView


class MyActivityIndicator: UIViewController , NVActivityIndicatorViewable {
    
    
    func startAnimation() {
        
        startAnimating(CGSize(width: 150, height: 150), message: "", messageFont: UIFont(name: "Baskerville", size: 20), type: NVActivityIndicatorType.ballScaleMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor:UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5) , fadeInAnimation: nil)
        
    }
        
    func stopAnimation() {
        stopAnimating()
    }
        
}
