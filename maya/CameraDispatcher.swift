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
  
  func getFrontCameraView(view: UIView) throws -> UIView {
    
    let cameraView = UIView()
    let captureSession = AVCaptureSession()
    var previewLayer = AVCaptureVideoPreviewLayer()
    let imageOutput = AVCaptureStillImageOutput()
    let frontCamera = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: AVCaptureDevicePosition.front)
    let input = try AVCaptureDeviceInput(device: frontCamera)
    
    captureSession.sessionPreset = AVCaptureSessionPresetHigh
    
    if (captureSession.canAddInput(input)) {
      captureSession.addInput(input)
      imageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
      
      if (captureSession.canAddOutput(imageOutput)) {
        captureSession.addOutput(imageOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
        previewLayer.frame = view.bounds
        captureSession.startRunning()
        cameraView.layer.addSublayer(previewLayer)
      }
    }
    
    return cameraView
  }
}
