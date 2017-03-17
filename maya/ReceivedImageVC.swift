//
//  ReceivedImageVC.swift
//  maya
//
//  Created by Martin Lasek on 10.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ReceivedImageVC: UIViewController {
  
  var receivedImageCollection: ReceivedImageCollectionView!
  let reuseIdentifier = "receivedImageCell"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    receivedImageCollection = ReceivedImageCollectionView(bounds: self.view.bounds, reuseIdentifier: reuseIdentifier)
    receivedImageCollection.setDelegate(delegate: self)
    receivedImageCollection.setDataSource(dataSource: self)
    self.view.addSubview(receivedImageCollection.view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    fetchReceivedImages()
  }
  
  func fetchReceivedImages() {
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
}

extension ReceivedImageVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // Specifying the number of sections in the collectionView
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  // Specifying the number of cells in the given section
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return receivedImageCollection.images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReceivedImageCollectionViewCell
    cell.awakeFromNib()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    let imageCell = cell as! ReceivedImageCollectionViewCell
    let image = receivedImageCollection.images[indexPath.row].image
    imageCell.receivedImageView.image = image
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width/3, height: self.view.frame.width/3)
  }
}
