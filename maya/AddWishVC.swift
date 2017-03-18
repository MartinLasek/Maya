//
//  AddWishVC.swift
//  maya
//
//  Created by Martin Lasek on 17.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class AddWishVC: UIViewController {

  var delegate: WishlistTableVC!
  var addWishView: AddWishView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    addWishView = AddWishView(bounds: self.view.bounds)
    addWishView.closeButton.addTarget(self, action: #selector(self.dismissController), for: .touchUpInside)
    addWishView.addButton.addTarget(self, action: #selector(self.addWish), for: .touchUpInside)
    
    self.view.addSubview(addWishView.view)
    self.view.addSubview(addWishView.closeButton)
    self.view.addSubview(addWishView.addButton)
    self.view.addSubview(addWishView.textView)
  }
  
  func dismissController() {
    self.dismiss(animated: true, completion: nil)
  }
  
  func addWish() throws {
    
    guard let wishText = addWishView.textView.text else {
      throw WishlistError.noWishTextToAdd
    }
    
    if (wishText.characters.count > 0) {
      let apiDispatcher = ApiDispatcher()
      
      try apiDispatcher.postWish(wish: wishText, complete: {
        self.delegate.fetchWishlist()
      })
      
      self.dismissController()
    }
  }
}
