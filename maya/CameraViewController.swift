//
//  CameraViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let cameraDispatcher = CameraDispatcher()
    
    do {
      let cameraView = try cameraDispatcher.getFrontCameraView(view: self.view)
      cameraView.layer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
      
      // used transition here because it is way faster than 'self.view.addSubview(cameraView)'
      UIView.transition(from: self.view, to: cameraView, duration: 0, options: UIViewAnimationOptions.transitionCurlUp, completion: nil)
    } catch {
      return
    }
  }
}
