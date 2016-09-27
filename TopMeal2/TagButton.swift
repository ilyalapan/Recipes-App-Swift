//
//  TagButton.swift
//  
//
//  Created by Ilya Lapan on 21/09/2016.
//
//

import UIKit


class TagButton: UIButton {

    
    var active: Bool = false {
        didSet{
            backgroundColor = active ? .red : .white
        }

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}
