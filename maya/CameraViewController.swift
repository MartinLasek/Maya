//
//  CameraViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
  
  var cameraView: CameraView!
  var imageView: TakenPhotoView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let cameraDispatcher = CameraDispatcher()
    
    self.cameraView = cameraDispatcher.getFrontCameraView(request: CameraViewRequest(bounds: self.view.bounds)).cameraView
    self.cameraView.shutterButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    self.imageView = TakenPhotoView(bounds: self.view.bounds)
    self.imageView.closeButton.addTarget(self, action: #selector(hideImageView), for: .touchUpInside)
    self.imageView.hide()
    
    self.view.addSubview(self.cameraView.view)
    self.view.addSubview(self.cameraView.shutterButton)
    self.view.addSubview(self.imageView.view)
    self.view.addSubview(self.imageView.nextButton)
    self.view.addSubview(self.imageView.closeButton)
  }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
  // starts taking a photo
  func takePhoto() {
    
    if let cameraView = self.cameraView, let videoConnection = cameraView.imageOutput.connection(withMediaType: AVMediaTypeVideo) {
      videoConnection.videoOrientation = AVCaptureVideoOrientation.portrait
      cameraView.imageOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
  }
  
  // callback is called when photo is taken
  func capture(_ captureOutput: AVCapturePhotoOutput,
               didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
               previewPhotoSampleBuffer: CMSampleBuffer?,
               resolvedSettings: AVCaptureResolvedPhotoSettings,
               bracketSettings: AVCaptureBracketedStillImageSettings?,
               error: Error?)
  {
    if let buffer = photoSampleBuffer, let imgData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: nil), let img = UIImage(data: imgData) {
      
      self.imageView.view.image = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
      self.imageView.show()
    }
  }
  
  func hideImageView() {
    self.imageView.hide()
  }
}
