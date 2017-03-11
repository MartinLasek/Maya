//
//  ReceivedPhotoVC.swift
//  maya
//
//  Created by Martin Lasek on 11.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ReceivedPhotoVC: UIViewController {

  var receivedPhotoView: ReceivedPhotoView!
  weak var delegate: CameraContainerVC!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    receivedPhotoView = ReceivedPhotoView(bounds: self.view.bounds)
    self.receivedPhotoView.closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
    
    self.view.addSubview(receivedPhotoView.imageView)
    self.view.addSubview(receivedPhotoView.closeButton)
  }
  
  func hideView() {
    self.view.isHidden = true
  }
  
  func unhideView() {
    self.view.isHidden = false
  }
  
  func closeView() {
    self.delegate.closeReceivedPhotoView()
  }
}
