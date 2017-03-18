//
//  AddWishButton.swift
//  maya
//
//  Created by Martin Lasek on 17.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class AddWishButton {
  
  var button: UIButton
  
  init(bounds: CGRect) {
    let border = CALayer()
    
    border.borderColor = UIColor.gray.cgColor
    border.borderWidth = 1
    border.frame = CGRect(x: 0, y: bounds.height * 0.08 - 1, width: bounds.width, height: 0.5)
    
    self.button = UIButton(frame: CGRect(x: 0, y: bounds.height * 0.26, width: bounds.width, height: bounds.height * 0.08))
    self.button.backgroundColor = UIColor.white
    self.button.setTitle("add wish", for: .normal)
    self.button.setTitleColor(UIColor.black, for: .normal)
    self.button.setTitleColor(UIColor.gray, for: .highlighted)
    self.button.layer.addSublayer(border)
  }
}
