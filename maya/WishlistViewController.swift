//
//  WishlistViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
  }
  
  func prepareView() {
    let gradient: CAGradientLayer = CAGradientLayer()
    let colorTop = UIColor(red: 255/255, green: 106/255, blue: 79/255, alpha: 1.0)
    let colorBottom = UIColor(red: 255/255, green: 70/255, blue: 115/255, alpha: 1.0)
    gradient.frame = self.view.bounds
    gradient.colors = [colorTop.cgColor, colorBottom.cgColor]
    self.view.layer.insertSublayer(gradient, at: 0)
  }
}
