//
//  BackgroundColorView.swift
//  maya
//
//  Created by Martin Lasek on 26.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class BackgroundColor {
  
  private let colorTop = UIColor(red: 255/255, green: 106/255, blue: 79/255, alpha: 1.0).cgColor
  private let colorBottom = UIColor(red: 255/255, green: 70/255, blue: 115/255, alpha: 1.0).cgColor
  let gradient = CAGradientLayer()
  
  init(bounds: CGRect) {
    gradient.frame = bounds
    gradient.colors = [colorTop, colorBottom]
  }
}
