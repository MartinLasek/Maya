//
//  WishlistCollectionView.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistCollectionView {
  
  var layout = UICollectionViewFlowLayout()
  var wishs = [WishlistEntity]()
  let bounds: CGRect
  var collectionView: UICollectionView
  
  init(bounds: CGRect, reuseIdentifier: String) {
    self.bounds = bounds
    
    collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
    collectionView.register(WishlistCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = UIColor.clear
    
    /** TESTING DATA **/
    
    for index in 1...23 {
      wishs.append(WishlistEntity(id: index, votes: Int(arc4random_uniform(100)), description: "I'd love to have transitions between all view changes"))
    }
  }
  
  func setDelegate(delegate: UICollectionViewDelegate) {
    collectionView.delegate = delegate
  }
  
  func setDataSource(dataSource: UICollectionViewDataSource) {
    collectionView.dataSource = dataSource
  }
}
