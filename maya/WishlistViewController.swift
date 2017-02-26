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
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
  }
}
