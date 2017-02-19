//
//  TakenPhotoView.swift
//  maya
//
//  Created by Martin Lasek on 19.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

/**
 ** class to hold image within imageview to
 ** display this view with taken image to user
 */
class TakenPhotoView {
  var view = UIImageView()
  let bounds: CGRect
  
  let closeButton = UIButton()
  let nextButton = UIButton()
  
  let closeImage = UIImage(named: "close-icon")
  let nextImage = UIImage(named: "next-icon")
  
  init(bounds: CGRect) {
    self.bounds = bounds
    self.view.frame = bounds
    
    nextButton.setImage(nextImage, for: .normal)
    nextButton.layer.frame = positionNextButton()
    
    closeButton.setImage(closeImage, for: .normal)
    closeButton.layer.frame = positionCloseButton()
  }
  
  func positionNextButton() -> CGRect {
    let buttonSize: CGFloat = 50
    // the tab bar is having 3 fields in which each field an icon is at the center
    // view width divided by 3 and again by 2 is the center of the first field,
    // dividing the item width by half will position the item visually at the center
    // if you'd multiply field positon by 6 again, you are at the screen edge right side
    let x = (self.bounds.size.width / 6) * 5 - (buttonSize / 2)
    let y = self.bounds.size.height - 125
    
    return CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
  }
  
  func positionCloseButton() -> CGRect {
    let buttonSize: CGFloat = 40
    // see 'positionNextButton()' comment for mathmatical explanation
    let x = (self.bounds.size.width / 6) - buttonSize / 2
    let y = self.bounds.size.height - 120
    
    return CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
  }
  
  /*
  ** hide this view and its buttons
  */
  func hide() {
    self.view.isHidden = true
    self.closeButton.isHidden = true
    self.nextButton.isHidden = true
  }
  
  /*
   ** reveals this view and its buttons
   */
  func show() {
    self.view.isHidden = false
    self.closeButton.isHidden = false
    self.nextButton.isHidden = false
  }
}
