//
//  ViewTitle.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ViewTitle {
  
  var title = UILabel()
  let bounds: CGRect
  
  init(bounds: CGRect) {
    self.bounds = bounds
    prepare()
  }
  
  func prepare() {
    let appearance = CGRect(x: 0 , y: self.bounds.height * 0.125 - 28, width: self.bounds.width, height: 28)
    title.frame = appearance
    title.textAlignment = .center
    title.textColor = UIColor.white
    title.font = UIFont.boldSystemFont(ofSize: 28)
    title.text = "wishlist"
  }
}
