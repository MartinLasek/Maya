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
    nextButton.layer.frame = CGRect(x: (self.bounds.size.width / 6) * 5 - 25, y: self.bounds.size.height - 125, width: CGFloat(50), height: CGFloat(50))
    
    closeButton.setImage(closeImage, for: .normal)
    closeButton.layer.frame = CGRect(x: (self.bounds.size.width / 6) - 20, y: self.bounds.size.height - 120, width: CGFloat(40), height: CGFloat(40))
  }
}
