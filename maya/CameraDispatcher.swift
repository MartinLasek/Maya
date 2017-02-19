//
//  CameraDispatcher.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit
import AVFoundation

class CameraDispatcher {
  
  func getFrontCameraView(request: CameraViewRequest) throws -> CameraViewResponse {
    
    let cameraView = CameraView(bounds: request.bounds)
    return CameraViewResponse(cameraView: cameraView.view)
  }
}
