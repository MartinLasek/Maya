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
    let buttonSize: CGFloat = 50
    
    self.button = UIButton(frame: CGRect(x: bounds.width * 0.5 - buttonSize / 2, y: bounds.height * 0.20 - buttonSize / 2, width: buttonSize, height: buttonSize))
    self.button.backgroundColor = UIColor.white
    self.button.layer.cornerRadius = buttonSize / 2
    self.button.setTitle("+", for: .normal)
    self.button.setTitleColor(UIColor.black, for: .normal)
    self.button.setTitleColor(UIColor.gray, for: .highlighted)
  }
}
