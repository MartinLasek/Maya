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
  var takenPhotoVC: TakenPhotoVC!
  var receivedPhotoVC: ReceivedPhotoVC!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    cameraVC = CameraVC()
    cameraVC.delegate = self
    cameraVC.view.frame = self.view.frame
    cameraVC.didMove(toParentViewController: self)
    
    takenPhotoVC = TakenPhotoVC()
    takenPhotoVC.delegate = self
    takenPhotoVC.view.frame = self.view.frame
    takenPhotoVC.didMove(toParentViewController: self)
    takenPhotoVC.hideView()
    
    receivedPhotoVC = ReceivedPhotoVC()
    receivedPhotoVC.delegate = self
    receivedPhotoVC.view.frame = self.view.frame
    receivedPhotoVC.didMove(toParentViewController: self)
    receivedPhotoVC.hideView()
    
    self.addChildViewController(cameraVC)
    self.addChildViewController(takenPhotoVC)
    self.addChildViewController(receivedPhotoVC)
    
    self.view.addSubview(cameraVC.view)
    self.view.addSubview(takenPhotoVC.view)
    self.view.addSubview(receivedPhotoVC.view)
  }
  
  func displayPhoto(img: UIImage) {
    self.takenPhotoVC.takenPhotoView.view.image = UIImage(cgImage: img.cgImage!, scale: 1.0, orientation: UIImageOrientation.leftMirrored)
    self.takenPhotoVC.unhideView()
    self.cameraVC.hideView()
  }
  
  func redoPhoto() {
    self.takenPhotoVC.takenPhotoView.view.image = nil
    self.takenPhotoVC.hideView()
    self.cameraVC.unhideView()
  }
  
  func closeReceivedPhotoView() {
    self.receivedPhotoVC.receivedPhotoView.imageView.image = nil
    self.receivedPhotoVC.hideView()
    self.cameraVC.unhideView()
  }
  
  func sendPhoto(img: UIImage) {
    let apiDispatcher = ApiDispatcher()
    apiDispatcher.postImage(req: SendImageRequest(image: img))
    
    apiDispatcher.getRandomImage(complete: { image in
      if let image = image {
        
        // needed to display received image imeadiatly
        DispatchQueue.main.async {
          self.receivedPhotoVC.receivedPhotoView.imageView.image = image
          self.takenPhotoVC.hideView()
          self.receivedPhotoVC.unhideView()
        }
      }
    })
  }
}
