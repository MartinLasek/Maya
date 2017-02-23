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
  var takenPhotoView: TakenPhotoView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.cameraView = CameraView(bounds: self.view.bounds)
    self.cameraView.shutterButton.addTarget(self, action: #selector(takePhoto), for: .touchUpInside)
    
    self.takenPhotoView = TakenPhotoView(bounds: self.view.bounds)
    self.takenPhotoView.closeButton.addTarget(self, action: #selector(hideImageView), for: .touchUpInside)
    self.takenPhotoView.nextButton.addTarget(self, action: #selector(sendImage), for: .touchUpInside)
    self.takenPhotoView.hide()
    
    self.view.addSubview(self.cameraView.view)
    self.view.addSubview(self.cameraView.shutterButton)
    self.view.addSubview(self.takenPhotoView.view)
    self.view.addSubview(self.takenPhotoView.nextButton)
    self.view.addSubview(self.takenPhotoView.closeButton)
  }
  
  /// Will stop the camera session
  /// It also prevents camera to freeze when returning from background.
  override func viewWillDisappear(_ animated: Bool) {
    self.cameraView.captureSession.stopRunning()
  }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
  
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
      
      self.takenPhotoView.view.image = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
      self.takenPhotoView.show()
    }
  }
  
  func hideImageView() {
    self.takenPhotoView.hide()
  }
  
  func sendImage() {
    let apiDispatcher = ApiDispatcher()
    
    if let image = self.takenPhotoView.view.image {
      apiDispatcher.postImage(req: SendImageRequest(image: image))
    }
    
    apiDispatcher.getRandomImage(complete: { image in
      if let image = image {
          self.takenPhotoView.view.image = image
      }
    })
  }
}
