//
//  CameraVC.swift
//  maya
//
//  Created by Martin Lasek on 11.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {

  var cameraView: CameraView!
  weak var delegate: CameraContainerVC!
  
  override func viewWillAppear(_ animated: Bool) {
    self.cameraView = CameraView(bounds: self.view.bounds)
    self.cameraView.shutterButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    
    self.view.addSubview(self.cameraView.view)
    self.view.addSubview(self.cameraView.shutterButton)
  }
  
  /// Will stop the camera session
  /// It also prevents camera to freeze when returning from background.
  override func viewWillDisappear(_ animated: Bool) {
    self.cameraView.captureSession.stopRunning()
  }
  
  func unhideView() {
    self.view.isHidden = false
  }
  
  func hideView() {
    self.view.isHidden = true
  }
}

extension CameraVC: AVCapturePhotoCaptureDelegate {
  
  /// Starts taking a photo.
  func takePhoto() {
    
    if let cameraView = self.cameraView, let videoConnection = cameraView.imageOutput.connection(withMediaType: AVMediaTypeVideo) {
      videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
      cameraView.imageOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
  }
  
  /// Callback fired when photo is taken.
  func capture(_ captureOutput: AVCapturePhotoOutput,
               didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
               previewPhotoSampleBuffer: CMSampleBuffer?,
               resolvedSettings: AVCaptureResolvedPhotoSettings,
               bracketSettings: AVCaptureBracketedStillImageSettings?,
               error: Error?)
  {
    if let buffer = photoSampleBuffer, let imgData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil), let img = UIImage(data: imgData) {
      
      self.delegate.displayPhoto(img: img)
    }
  }
}
