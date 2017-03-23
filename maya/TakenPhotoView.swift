//
//  TakenPhotoView.swift
//  maya
//
//  Created by Martin Lasek on 19.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class TakenPhotoView {
  
  var view = UIImageView()
  let bounds: CGRect
  
  let closeButton = UIButton()
  let nextButton = UIButton()
  
  let closeImage = UIImage(named: "Redo")
  let nextImage = UIImage(named: "Send")
  
  init(bounds: CGRect) {
    self.bounds = bounds
    self.view.frame = bounds
    
    nextButton.setImage(nextImage, for: .normal)
    nextButton.layer.frame = positionNextButton()
    
    closeButton.setImage(closeImage, for: .normal)
    closeButton.layer.frame = positionCloseButton()
  }
  
  func positionNextButton() -> CGRect {
    let buttonSize: CGFloat = 60
    // the tab bar is having 3 fields in which each field an icon is at the center
    // view width divided by 3 and again by 2 is the center of the first field,
    // dividing the item width by half will position the item visually at the center
    // if you'd multiply field positon by 6 again, you are at the screen edge right side
    let x = (self.bounds.size.width / 6) * 5 - (buttonSize / 2)
    let y = self.bounds.size.height - 130
    
    return CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
  }
  
  func positionCloseButton() -> CGRect {
    let buttonSize: CGFloat = 60
    // see 'positionNextButton()' comment for mathmatical explanation
    let x = (self.bounds.size.width / 6) - buttonSize / 2
    let y = self.bounds.size.height - 130
    
    return CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
  }
}
