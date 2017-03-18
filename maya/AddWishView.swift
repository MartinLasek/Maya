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
    self.view = UIView(frame: CGRect(x: 0, y: 50, width: bounds.width, height: bounds.height - 51))
    prepare()
  }
  
  func prepare() {
    let buttonWidth = bounds.width * 0.5
    let buttonHeight: CGFloat = self.bounds.height * 0.08
    let spaceToTop: CGFloat = 50
    let borderHorizontal = CALayer()
    let borderVertical = CALayer()
    
    borderHorizontal.borderColor = UIColor.lightGray.cgColor
    borderHorizontal.borderWidth = 1
    borderHorizontal.frame = CGRect(x: 0, y: buttonHeight, width: bounds.width, height: 0.5)
    
    borderVertical.borderColor = UIColor.lightGray.cgColor
    borderVertical.borderWidth = 1
    borderVertical.frame = CGRect(x: buttonWidth, y: 0, width: 0.5, height: buttonHeight)
    
    self.view.layer.cornerRadius = 15
    self.view.backgroundColor = UIColor.white
    self.view.layer.addSublayer(borderHorizontal)
    self.view.layer.addSublayer(borderVertical)
    
    self.closeButton.setTitle("close", for: .normal)
    self.closeButton.setTitleColor(UIColor.black, for: .normal)
    self.closeButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.closeButton.frame = CGRect(x: 0, y: spaceToTop, width: buttonWidth, height: buttonHeight)
    
    self.createButton.setTitle("add", for: .normal)
    self.createButton.setTitleColor(UIColor.black, for: .normal)
    self.createButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.createButton.frame = CGRect(x: buttonWidth, y: spaceToTop, width: buttonWidth, height: buttonHeight)
  }
}
