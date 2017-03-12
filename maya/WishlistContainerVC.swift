//
//  WishlistViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistContainerVC: UIViewController {
  
  var viewTitle: WishlistViewTitle!
  var wishlistTableVC: WishlistTableVC!
  
  override func viewDidLoad() {
    prepareView()
    
    wishlistTableVC = WishlistTableVC()
    wishlistTableVC.view.frame.size.height = self.view.bounds.height * 0.66
    wishlistTableVC.view.frame.origin.y = self.view.bounds.height * 0.34 - (tabBarController?.tabBar.frame.height)!
    wishlistTableVC.didMove(toParentViewController: self)
    
    self.addChildViewController(wishlistTableVC)
    self.view.addSubview(wishlistTableVC.view)
  }
  
  func prepareView() {
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
    
    self.viewTitle = WishlistViewTitle(bounds: self.view.bounds)
    self.view.addSubview(self.viewTitle.title)
  }
}
