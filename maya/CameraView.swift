//
//  CameraView.swift
//  maya
//
//  Created by Martin Lasek on 19.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView {
  let view = UIView()
  let bounds: CGRect
  let captureSession = AVCaptureSession()
  var previewLayer = AVCaptureVideoPreviewLayer()
  let imageOutput = AVCapturePhotoOutput()
  let frontCamera = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.front)
  
  let shutterButton = UIButton()
  let closeButton = UIButton()
  let nextButton = UIButton()
  
  let shutterImage = UIImage(named: "shutter-icon")
  let closeImage = UIImage()
  let nextImage = UIImage()

  init(bounds: CGRect) {
    self.bounds = bounds
    
    do {
      let input = try AVCaptureDeviceInput(device: frontCamera)
      
      captureSession.sessionPreset = AVCaptureSessionPresetHigh
      
      if (captureSession.canAddInput(input)) {
        captureSession.addInput(input)
        
        if (captureSession.canAddOutput(imageOutput)) {
          captureSession.addOutput(imageOutput)
          previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
          previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
          previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
          previewLayer.frame = bounds
          view.layer.addSublayer(previewLayer)
          captureSession.startRunning()
        }
      }
    } catch {
      return
    }
    
    setupButtons()
  }
  
  func setupButtons() {
    shutterButton.layer.frame = CGRect(x: self.bounds.size.width / 2 - 30, y: self.bounds.size.height - 130, width: CGFloat(60), height: CGFloat(60))
    shutterButton.setImage(shutterImage, for: .normal)
    view.addSubview(shutterButton)
  }
}
