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
  
  init(bounds: CGRect) {
    self.bounds = bounds
    self.view.frame = bounds
  }
}
