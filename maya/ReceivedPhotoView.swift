//
//  ReceivedPhotoView.swift
//  maya
//
//  Created by Martin Lasek on 11.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ReceivedPhotoView {
  
  var imageView = UIImageView()
  let bounds: CGRect
  
  let closeButton = UIButton()
  let closeImage = UIImage(named: "close-icon")
  
  init(bounds: CGRect) {
    self.bounds = bounds
    self.imageView.frame = bounds
    
    closeButton.setImage(closeImage, for: .normal)
    closeButton.layer.frame = positionCloseButton()
  }
  
  func positionCloseButton() -> CGRect {
    let buttonSize: CGFloat = 40
    let x = (self.bounds.width / 2) - (buttonSize / 2)
    let y = self.bounds.height - 120
    
    return CGRect(x: x, y: y, width: buttonSize, height: buttonSize)
  }
}
