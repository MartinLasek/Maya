//
//  GalleryViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  
  var sentImageCollectionView: SentImageCollectionView!
  var receivedImageCollectionView: SentImageCollectionView!
  var galleryTabBar: GalleryTabView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sentImageCollectionView = SentImageCollectionView(bounds: self.view.bounds)
    sentImageCollectionView.setDelegate(delegate: self)
    sentImageCollectionView.setDataSource(dataSource: self)
    sentImageCollectionView.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    
    receivedImageCollectionView = SentImageCollectionView(bounds: self.view.bounds)
    receivedImageCollectionView.setDelegate(delegate: self)
    receivedImageCollectionView.setDataSource(dataSource: self)
    receivedImageCollectionView.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    receivedImageCollectionView.view.isHidden = true
    
    galleryTabBar = GalleryTabView(bounds: self.view.bounds)
    galleryTabBar.sentTab.addTarget(self, action: #selector(showSentImageCollection), for: .touchUpInside)
    galleryTabBar.receivedTab.addTarget(self, action: #selector(showReceivedImageCollection), for: .touchUpInside)
    
    self.view.addSubview(sentImageCollectionView.view)
    self.view.addSubview(receivedImageCollectionView.view)
    self.view.addSubview(galleryTabBar.sentTab)
    self.view.addSubview(galleryTabBar.receivedTab)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
    getSentImages()
  }
  
  func getSentImages() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getImages(imageTypeUrl: ApiDispatcher.getSentImagesUrl, complete: { image in
      
      /// only appends images which didn't exist before
      if !self.sentImageCollectionView.images.contains(where: {$0.name == image.name}) {
        self.sentImageCollectionView.images.append(image)
        self.sentImageCollectionView.view.reloadData()
      }
    })
  }
  
  func getReceivedImages() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getImages(imageTypeUrl: ApiDispatcher.getReceivedImagesUrl, complete: { image in
      
      /// only appends images which didn't exist before
      if !self.receivedImageCollectionView.images.contains(where: {$0.name == image.name}) {
        self.receivedImageCollectionView.images.append(image)
        self.receivedImageCollectionView.view.reloadData()
      }
    })
  }
  
  func prepareView() {
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
  }
  
  func showSentImageCollection() {
    self.receivedImageCollectionView.view.isHidden = true
    self.sentImageCollectionView.view.isHidden = false
    getSentImages()
  }
  
  func showReceivedImageCollection() {
    self.sentImageCollectionView.view.isHidden = true
    self.receivedImageCollectionView.view.isHidden = false
    getReceivedImages()
  }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sentImageCollectionView.view.isHidden ? receivedImageCollectionView.images.count : sentImageCollectionView.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SentImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! SentImageCollectionViewCell
    let image = sentImageCollectionView.view.isHidden ? receivedImageCollectionView.images[indexPath.row].image : sentImageCollectionView.images[indexPath.row].image
    imageCell.sentImageView.image = image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
