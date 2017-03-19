//
//  AddWishView.swift
//  maya
//
//  Created by Martin Lasek on 16.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class AddWishView {
  
  let viewHeight: CGFloat
  let viewWidth: CGFloat
  var view: UIView
  var textView = UITextView()
  var closeButton = UIButton()
  var addButton = UIButton()
  
  init (bounds: CGRect) {
    self.viewHeight = bounds.height - 51
    self.viewWidth = bounds.width
    self.view = UIView(frame: CGRect(x: 0, y: 50, width: self.viewWidth, height: self.viewHeight))
    prepare()
  }
  
  func prepare() {
    let buttonWidth = self.viewWidth * 0.5
    let buttonHeight: CGFloat = 50
    let spaceToTop: CGFloat = 50
    let borderHorizontal = CALayer()
    let borderVertical = CALayer()
    
    borderHorizontal.borderColor = UIColor.lightGray.cgColor
    borderHorizontal.borderWidth = 1
    borderHorizontal.frame = CGRect(x: 0, y: buttonHeight - 0.5, width: self.viewWidth, height: 0.5)
    
    borderVertical.borderColor = UIColor.lightGray.cgColor
    borderVertical.borderWidth = 1
    borderVertical.frame = CGRect(x: buttonWidth, y: 0, width: 0.5, height: buttonHeight)
    
    // styling view
    self.view.layer.cornerRadius = 15
    self.view.backgroundColor = UIColor.white
    self.view.layer.addSublayer(borderHorizontal)
    self.view.layer.addSublayer(borderVertical)
    
    self.closeButton.setTitle("close", for: .normal)
    self.closeButton.setTitleColor(UIColor.black, for: .normal)
    self.closeButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.closeButton.frame = CGRect(x: 0, y: spaceToTop, width: buttonWidth, height: buttonHeight)
    
    self.addButton.setTitle("add", for: .normal)
    self.addButton.setTitleColor(UIColor.black, for: .normal)
    self.addButton.setTitleColor(UIColor.gray, for: .highlighted)
    self.addButton.frame = CGRect(x: buttonWidth, y: spaceToTop, width: buttonWidth, height: buttonHeight)
    
    self.textView.frame = CGRect(x: 0, y: spaceToTop + buttonHeight, width: self.viewWidth, height: self.viewHeight)
    self.textView.becomeFirstResponder()
  }
}
