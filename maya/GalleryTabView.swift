//
//  GalleryTabView.swift
//  maya
//
//  Created by Martin Lasek on 27.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryTabView {
  var sentTab = UIButton()
  var receivedTab = UIButton()
  let bounds: CGRect
  
  init(bounds: CGRect) {
    self.bounds = bounds
    
    prepare()
  }
  
  func prepare() {
    sentTab.layer.frame = CGRect(x: 0, y: bounds.height * 0.26, width: bounds.width/2, height: bounds.height * 0.08)
    sentTab.backgroundColor = UIColor.white
    sentTab.setTitle("sent", for: .normal)
    sentTab.setTitleColor(UIColor.black, for: .normal)
    receivedTab.layer.frame = CGRect(x: bounds.width/2, y: bounds.height * 0.26, width: bounds.width/2, height: bounds.height * 0.08)
    receivedTab.backgroundColor = UIColor.white
    receivedTab.setTitle("received", for: .normal)
    receivedTab.setTitleColor(UIColor.black, for: .normal)
  }
}
