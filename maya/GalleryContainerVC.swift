//
//  GalleryViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryContainerVC: UIViewController {
  
  var receivedImageCollection: ImageCollectionView!
  var galleryTabBar: GalleryTabView!
  let reuseIdentifier = "imageCell"
  
  var sentImageCollectionVC: SentImageVC!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    receivedImageCollection = ImageCollectionView(bounds: self.view.bounds, reuseIdentifier: reuseIdentifier)
    receivedImageCollection.setDelegate(delegate: self)
    receivedImageCollection.setDataSource(dataSource: self)
    receivedImageCollection.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    receivedImageCollection.view.isHidden = true
    
    galleryTabBar = GalleryTabView(bounds: self.view.bounds)
    galleryTabBar.sentTab.addTarget(self, action: #selector(showSentImageCollection), for: .touchUpInside)
    galleryTabBar.receivedTab.addTarget(self, action: #selector(showReceivedImageCollection), for: .touchUpInside)
    galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    
    self.view.addSubview(receivedImageCollection.view)
    self.view.addSubview(galleryTabBar.sentTab)
    self.view.addSubview(galleryTabBar.receivedTab)
    
    /* BREAKING CHANGES */
    
    let collectionContainerView = CollectionContainerView(bounds: self.view.bounds)
    collectionContainerView.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    
    sentImageCollectionVC = SentImageVC()
    sentImageCollectionVC.view.frame.size.height = collectionContainerView.view.frame.height
    sentImageCollectionVC.sentImageCollection.view.frame.size.height = collectionContainerView.view.frame.height
    collectionContainerView.view.addSubview(sentImageCollectionVC.view)
    sentImageCollectionVC.didMove(toParentViewController: self)
    self.addChildViewController(sentImageCollectionVC)
    self.view.addSubview(collectionContainerView.view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
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
    self.sentImageCollectionVC.view.isHidden = false
    self.galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.gray, for: .normal)
  }
  
  func showReceivedImageCollection() {
    self.receivedImageCollection.view.isHidden = false
    self.sentImageCollectionVC.view.isHidden = true
    self.galleryTabBar.sentTab.setTitleColor(UIColor.gray, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.black, for: .normal)
    getReceivedImages()
  }
}

extension GalleryContainerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return receivedImageCollection.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! ImageCollectionViewCell
    let image = receivedImageCollection.images[indexPath.row].image
    imageCell.sentImageView.image = image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
