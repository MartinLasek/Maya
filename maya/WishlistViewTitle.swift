//
//  ViewTitle.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistViewTitle {
  
  var title = UILabel()
  let titleHeight: CGFloat = 28
  
  init(bounds: CGRect) {
    title.frame = CGRect(x: 0 , y: bounds.height * 0.125 - titleHeight, width: bounds.width, height: titleHeight)
    title.textAlignment = .center
    title.textColor = UIColor.white
    title.font = UIFont.boldSystemFont(ofSize: titleHeight)
    title.text = "Add a wish"
  }
}
