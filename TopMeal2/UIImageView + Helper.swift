//
//  SDWebImageExtension.swift
//  TopMeal2
//
//  Created by Ilya Lapan on 21/10/2016.
//  Copyright © 2016 ilyaseva. All rights reserved.
//

import Foundation


extension UIImageView {
    
    func sd_setImage(string: String) {
        
        let URL = NSURL(string: string)
        self.sd_setImage(with: URL?.absoluteURL)
    }
}
