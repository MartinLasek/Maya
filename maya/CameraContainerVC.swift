//
//  CameraViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit
import AVFoundation

class CameraContainerVC: UIViewController {
  
  var cameraVC: CameraVC!
  var takenPhotoView: TakenPhotoView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.takenPhotoView = TakenPhotoView(bounds: self.view.bounds)
    self.takenPhotoView.closeButton.addTarget(self, action: #selector(hideImageView), for: .touchUpInside)
    self.takenPhotoView.nextButton.addTarget(self, action: #selector(sendImage), for: .touchUpInside)
    self.takenPhotoView.hide()
    
    self.view.addSubview(self.takenPhotoView.view)
    self.view.addSubview(self.takenPhotoView.nextButton)
    self.view.addSubview(self.takenPhotoView.closeButton)
    
    cameraVC = CameraVC()
    cameraVC.delegate = self
    cameraVC.view.frame = self.view.frame
    cameraVC.didMove(toParentViewController: self)
    self.addChildViewController(cameraVC)
    self.view.addSubview(cameraVC.view)
  }
  
  func hideImageView() {
    self.takenPhotoView.hide()
    self.cameraVC.view.isHidden = false
  }
  
  func displayPhoto(img: UIImage) {
    self.takenPhotoView.view.image = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
    self.takenPhotoView.show()
    self.cameraVC.view.isHidden = true
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
