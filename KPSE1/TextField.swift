//
//  TextField.swift
//  KPSE1
//
//  Created by KPSBremen on 19/10/16.
//  Copyright © 2016 KPSBremen. All rights reserved.
//

import UIKit

extension UITextField
{
    func setBottomBorder(color:String)
    {
        self.borderStyle = UITextBorderStyle.None;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
