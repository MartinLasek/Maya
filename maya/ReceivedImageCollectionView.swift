//
//  ReceivedImageCollectionView.swift
//  maya
//
//  Created by Martin Lasek on 10.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ReceivedImageCollectionView {
  
  var layout = UICollectionViewFlowLayout()
  var images = [ImageEntity]()
  let bounds: CGRect
  var view: UICollectionView
  
  init(bounds: CGRect, reuseIdentifier: String) {
    self.bounds = bounds
    
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    
    view = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
    view.register(ReceivedImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    view.backgroundColor = UIColor.white
    view.alwaysBounceVertical = true
  }
  
  func setDelegate(delegate: UICollectionViewDelegate) {
    view.delegate = delegate
  }
  
  func setDataSource(dataSource: UICollectionViewDataSource) {
    view.dataSource = dataSource
  }
}
