//
//  AddWishView.swift
//  maya
//
//  Created by Martin Lasek on 16.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class AddWishView {
  
  let bounds: CGRect
  var view: UIView
  var wishTextField = UITextField()
  var closeButton = UIButton()
  var createButton = UIButton()
  
  init (bounds: CGRect) {
    self.bounds = bounds
    self.view = UIView(frame: CGRect(x: 0, y: 20, width: bounds.width, height: bounds.height * 0.9))
    
    prepare()
  }
  
  func prepare() {
    let buttonWidth = bounds.width * 0.5
    let buttonHeight: CGFloat = 45
    let topBarHeight: CGFloat = 20
    let border = CALayer()
    
    border.borderColor = UIColor.gray.cgColor
    border.borderWidth = 1
    border.frame = CGRect(x: 0, y: buttonHeight, width: bounds.width, height: 0.5)
    
    self.view.layer.cornerRadius = 15
    self.view.backgroundColor = UIColor.white
    self.view.layer.addSublayer(border)
    
    self.closeButton.setTitle("close", for: .normal)
    self.closeButton.setTitleColor(UIColor.black, for: .normal)
    self.closeButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.closeButton.frame = CGRect(x: 0, y: topBarHeight, width: buttonWidth, height: buttonHeight)
    
    self.createButton.setTitle("add", for: .normal)
    self.createButton.setTitleColor(UIColor.black, for: .normal)
    self.createButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.createButton.frame = CGRect(x: buttonWidth, y: topBarHeight, width: buttonWidth, height: buttonHeight)
  }
}
