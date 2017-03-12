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
  var collectionView: UICollectionView
  
  init(bounds: CGRect, reuseIdentifier: String) {
    collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
    collectionView.register(WishlistCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionView.backgroundColor = UIColor.clear
  }
  
  func setDelegate(delegate: UICollectionViewDelegate) {
    collectionView.delegate = delegate
  }
  
  func setDataSource(dataSource: UICollectionViewDataSource) {
    collectionView.dataSource = dataSource
  }
}
