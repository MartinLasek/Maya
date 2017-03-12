//
//  WishlistVC.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistVC: UIViewController {

  var wishlistCollection: WishlistCollectionView!
  let reuseIdentifier = "wishCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    wishlistCollection = WishlistCollectionView(bounds: self.view.bounds, reuseIdentifier: reuseIdentifier)
    wishlistCollection.setDelegate(delegate: self)
    wishlistCollection.setDataSource(dataSource: self)
    self.view.addSubview(wishlistCollection.collectionView)
  }
}

extension WishlistVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return wishlistCollection.wishs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WishlistCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let wishCell = cell as! WishlistCollectionViewCell
    wishCell.text.text = wishlistCollection.wishs[indexPath.row].description
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width, height: 50)
  }
}
