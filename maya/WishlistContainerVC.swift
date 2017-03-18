//
//  WishlistViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistContainerVC: UIViewController {
  
  var wishlistTableVC: WishlistTableVC!
  
  override func viewDidLoad() {
    prepareView()
    
    wishlistTableVC = WishlistTableVC()
    wishlistTableVC.view.frame.size.height = self.view.bounds.height * 0.66 - (tabBarController?.tabBar.frame.height)!
    wishlistTableVC.view.frame.origin.y = self.view.bounds.height * 0.34
    wishlistTableVC.didMove(toParentViewController: self)
    
    self.addChildViewController(wishlistTableVC)
    self.view.addSubview(wishlistTableVC.view)
  }
  
  func prepareView() {
    let viewTitle = WishlistViewTitle(bounds: self.view.bounds)
    let addWishButton = AddWishButton(bounds: self.view.bounds)
    addWishButton.button.addTarget(self, action: #selector(openAddWishModal), for: .touchUpInside)
    
    self.view.layer.insertSublayer(BackgroundColor(bounds: self.view.bounds).gradient, at: 0)
    self.view.addSubview(viewTitle.title)
    self.view.addSubview(addWishButton.button)
  }
  
  func openAddWishModal() {
    let addWishVC = AddWishVC()
    addWishVC.modalPresentationStyle = .overCurrentContext
    addWishVC.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    present(addWishVC, animated: true, completion: nil)
  }
}
