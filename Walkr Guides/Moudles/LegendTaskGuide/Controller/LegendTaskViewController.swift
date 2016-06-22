//
//  LegendTaskViewController.swift
//  Walkr Guides
//
//  Created by GrayLand on 16/4/19.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

import Foundation
import UIKit



class LegendTaskViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = WGTestView.init(frame:CGRectMake(0, 64, 50, 50)) // UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor.greenColor()
        self.view.addSubview(view)
    }
}