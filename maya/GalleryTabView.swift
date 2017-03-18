//
//  GalleryTabView.swift
//  maya
//
//  Created by Martin Lasek on 27.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryTabView {
  var sentTab: UIButton
  var receivedTab: UIButton
  
  init(bounds: CGRect) {
    let buttonHeight = bounds.height * 0.08
    let buttonWidth = bounds.width/2
    
    sentTab = UIButton(frame: CGRect(x: 0, y: bounds.height * 0.26, width: buttonWidth, height: buttonHeight))
    sentTab.backgroundColor = UIColor.white
    sentTab.setTitle("sent", for: .normal)
    sentTab.setTitleColor(UIColor.gray, for: .normal)
    
    receivedTab = UIButton(frame: CGRect(x: buttonWidth, y: bounds.height * 0.26, width: buttonWidth, height: buttonHeight))
    receivedTab.backgroundColor = UIColor.white
    receivedTab.setTitle("received", for: .normal)
    receivedTab.setTitleColor(UIColor.gray, for: .normal)
  }
}
