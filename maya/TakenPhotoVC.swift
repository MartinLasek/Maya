//
//  TakenPhotoVC.swift
//  maya
//
//  Created by Martin Lasek on 11.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class TakenPhotoVC: UIViewController {

  var takenPhotoView: TakenPhotoView!
  weak var delegate: CameraContainerVC!
  
  override func viewDidLoad() {    
    takenPhotoView = TakenPhotoView(bounds: self.view.bounds)
    self.takenPhotoView.closeButton.addTarget(self, action: #selector(redoPhoto), for: .touchUpInside)
    self.takenPhotoView.nextButton.addTarget(self, action: #selector(sendPhoto), for: .touchUpInside)
    
    self.view.addSubview(self.takenPhotoView.view)
    self.view.addSubview(self.takenPhotoView.closeButton)
    self.view.addSubview(self.takenPhotoView.nextButton)
  }
  
  func hideView() {
    self.view.isHidden = true
  }
  
  func unhideView() {
    self.view.isHidden = false
  }
  
  func redoPhoto() {
    self.delegate.redoPhoto()
  }
  
  func sendPhoto() {
    if let img = self.takenPhotoView.view.image {
      self.delegate.sendPhoto(img: img)
    }
  }
}
