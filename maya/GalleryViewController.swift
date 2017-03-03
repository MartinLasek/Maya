//
//  GalleryViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
  
  var sentImageCollection: ImageCollectionView!
  var receivedImageCollection: ImageCollectionView!
  var galleryTabBar: GalleryTabView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sentImageCollection = ImageCollectionView(bounds: self.view.bounds)
    sentImageCollection.setDelegate(delegate: self)
    sentImageCollection.setDataSource(dataSource: self)
    sentImageCollection.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    
    receivedImageCollection = ImageCollectionView(bounds: self.view.bounds)
    receivedImageCollection.setDelegate(delegate: self)
    receivedImageCollection.setDataSource(dataSource: self)
    receivedImageCollection.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    receivedImageCollection.view.isHidden = true
    
    galleryTabBar = GalleryTabView(bounds: self.view.bounds)
    galleryTabBar.sentTab.addTarget(self, action: #selector(showSentImageCollection), for: .touchUpInside)
    galleryTabBar.receivedTab.addTarget(self, action: #selector(showReceivedImageCollection), for: .touchUpInside)
    galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    
    self.view.addSubview(sentImageCollection.view)
    self.view.addSubview(receivedImageCollection.view)
    self.view.addSubview(galleryTabBar.sentTab)
    self.view.addSubview(galleryTabBar.receivedTab)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
    getSentImages()
  }
  
  func getSentImages() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getImages(fromUrl: ApiDispatcher.getSentImagesUrl, complete: { imageName in
      
      /// only appends images which didn't exist before
      if !self.sentImageCollection.images.contains(where: {$0.name == imageName}) {
        
        do {
          let imageUrl = ImageEntity.getImageUrl(imageName: imageName)
          if let url = URL(string: imageUrl) {
            let data = try Data(contentsOf: url)
            let image = ImageEntity(image: UIImage(data: data)!, name: imageName)
            image.rotate(by: 90)
            
            self.sentImageCollection.images.append(image)
            
            DispatchQueue.main.async(execute: {
              self.sentImageCollection.view.reloadData()
            })
          }
        } catch {
          return
        }
      }
    })
  }
  
  func getReceivedImages() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getImages(fromUrl: ApiDispatcher.getReceivedImagesUrl, complete: { imageName in
      
      /// only appends images which didn't exist before
      if !self.receivedImageCollection.images.contains(where: {$0.name == imageName}) {
        
        do {
          let imageUrl = ImageEntity.getImageUrl(imageName: imageName)
          if let url = URL(string: imageUrl) {
            let data = try Data(contentsOf: url)
            let image = ImageEntity(image: UIImage(data: data)!, name: imageName)
            image.rotate(by: 90)
            
            self.receivedImageCollection.images.append(image)
            
            DispatchQueue.main.async(execute: {
              self.receivedImageCollection.view.reloadData()
            })
          }
        } catch {
          return
        }
      }
    })
  }
  
  func prepareView() {
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
  }
  
  func showSentImageCollection() {
    self.receivedImageCollection.view.isHidden = true
    self.sentImageCollection.view.isHidden = false
    self.galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.gray, for: .normal)
    getSentImages()
  }
  
  func showReceivedImageCollection() {
    self.receivedImageCollection.view.isHidden = false
    self.sentImageCollection.view.isHidden = true
    self.galleryTabBar.sentTab.setTitleColor(UIColor.gray, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.black, for: .normal)
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
    return sentImageCollection.view.isHidden ? receivedImageCollection.images.count : sentImageCollection.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! ImageCollectionViewCell
    let image = sentImageCollection.view.isHidden ? receivedImageCollection.images[indexPath.row].image : sentImageCollection.images[indexPath.row].image
    imageCell.sentImageView.image = image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
