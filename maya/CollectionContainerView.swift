//
//  CollectionContainerView.swift
//  maya
//
//  Created by Martin Lasek on 10.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class CollectionContainerView {
  
  let view: UIView
  
  init(bounds: CGRect) {
    self.view = UIView(frame: CGRect(x: 0, y: bounds.height * 0.34, width: bounds.width, height: bounds.height * 0.66))
  }
}
