//
//  WishlistViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistContainerVC: UIViewController {
  
  var viewTitle: ViewTitle!
  var wishlistVC: WishlistVC!
  
  override func viewDidLoad() {
    prepareView()
    
    wishlistVC = WishlistVC()
    wishlistVC.view.frame.size.height = self.view.bounds.height * 0.66
    wishlistVC.view.frame.origin.y = self.view.bounds.height * 0.34
    wishlistVC.didMove(toParentViewController: self)
    
    self.addChildViewController(wishlistVC)
    self.view.addSubview(wishlistVC.view)
  }
  
  func prepareView() {
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
    
    self.viewTitle = ViewTitle(bounds: self.view.bounds)
    self.view.addSubview(self.viewTitle.title)
  }
}
