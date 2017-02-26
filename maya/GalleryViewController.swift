//
//  GalleryViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  var collectionViewContainer: SentImageCollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionViewContainer = SentImageCollectionView(bounds: self.view.bounds)
    collectionViewContainer.setDelegate(delegate: self)
    collectionViewContainer.setDataSource(dataSource: self)
    collectionViewContainer.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    self.view.addSubview(collectionViewContainer.view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
    getSentImages()
  }
  
  func getSentImages() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getSentImages(complete: { image in
      
      /// only appends images which didn't exist before
      if !self.collectionViewContainer.images.contains(where: {$0.name == image.name}) {
        self.collectionViewContainer.images.append(image)
        self.collectionViewContainer.view.reloadData()
      }
    })
  }
  
  func prepareView() {
    let gradient: CAGradientLayer = CAGradientLayer()
    let colorTop = UIColor(red: 255/255, green: 106/255, blue: 79/255, alpha: 1.0)
    let colorBottom = UIColor(red: 255/255, green: 70/255, blue: 115/255, alpha: 1.0)
    gradient.frame = self.view.bounds
    gradient.colors = [colorTop.cgColor, colorBottom.cgColor]
    self.view.layer.insertSublayer(gradient, at: 0)
  }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return collectionViewContainer.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SentImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! SentImageCollectionViewCell
    imageCell.sentImageView.image = collectionViewContainer.images[indexPath.row].image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
