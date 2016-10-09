//
//  PrettyNavigationBar.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 06/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import UIKit

class PrettyNavigationBar: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setBackgroundImage(#imageLiteral(resourceName: "navigationBar"), for: .default)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
