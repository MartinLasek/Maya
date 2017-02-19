//
//  CameraViewRequest.swift
//  maya
//
//  Created by Martin Lasek on 19.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//
import UIKit

class CameraViewRequest {
  
  // bounds the camera view will be set to
  var bounds: CGRect
  
  init(bounds: CGRect) {
    self.bounds = bounds
  }
}
