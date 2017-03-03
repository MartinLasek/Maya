//
//  CollectionView.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ImageCollectionView {
  
  var layout = UICollectionViewFlowLayout()
  var images = [ImageEntity]()
  let bounds: CGRect
  var view: UICollectionView
  
  init(bounds: CGRect) {
    self.bounds = bounds
    
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0
    
    view = UICollectionView(frame: CGRect(x: 0, y: bounds.height * 0.34, width: bounds.width, height: bounds.height * 0.66), collectionViewLayout: layout)
    view.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "imageCell")
    view.backgroundColor = UIColor.white
  }
  
  func setDelegate(delegate: UICollectionViewDelegate) {
    view.delegate = delegate
  }
  
  func setDataSource(dataSource: UICollectionViewDataSource) {
    view.dataSource = dataSource
  }
}
