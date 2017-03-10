//
//  SentImageVC.swift
//  maya
//
//  Created by Martin Lasek on 10.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class SentImageVC: UIViewController {

  var sentImageCollection: SentImageCollectionView!
  let reuseIdentifier = "sentImageCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    sentImageCollection = SentImageCollectionView(bounds: self.view.bounds, reuseIdentifier: reuseIdentifier)
    sentImageCollection.setDelegate(delegate: self)
    sentImageCollection.setDataSource(dataSource: self)
    
    self.view.backgroundColor = UIColor.black
    self.view.addSubview(sentImageCollection.view)
  }

  override func viewWillAppear(_ animated: Bool) {
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
}

extension SentImageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sentImageCollection.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! SentImageCollectionViewCell
    let image = sentImageCollection.images[indexPath.row].image
    imageCell.sentImageView.image = image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
