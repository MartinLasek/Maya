//
//  AddWishVC.swift
//  maya
//
//  Created by Martin Lasek on 17.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class AddWishVC: UIViewController {

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let addWishView = AddWishView(bounds: self.view.bounds)
    addWishView.closeButton.addTarget(self, action: #selector(self.dismissController), for: .touchUpInside)
    
    self.view.addSubview(addWishView.view)
    self.view.addSubview(addWishView.closeButton)
    self.view.addSubview(addWishView.createButton)
    self.view.addSubview(addWishView.textView)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //self.dismiss(animated: true, completion: nil)
  }
  
  func dismissController() {
    self.dismiss(animated: true, completion: nil)
  }
}
