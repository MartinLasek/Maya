//
//  GalleryViewController.swift
//  maya
//
//  Created by Martin Lasek on 18.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class GalleryContainerVC: UIViewController {
  
  var galleryTabBar: GalleryTabView!
  var sentImageCollectionVC: SentImageVC!
  var receivedImageCollectionVC: ReceivedImageVC!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    galleryTabBar = GalleryTabView(bounds: self.view.bounds)
    galleryTabBar.sentTab.addTarget(self, action: #selector(showSentImageCollection), for: .touchUpInside)
    galleryTabBar.receivedTab.addTarget(self, action: #selector(showReceivedImageCollection), for: .touchUpInside)
    galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    
    let collectionContainerView = CollectionContainerView(bounds: self.view.bounds)
    collectionContainerView.view.frame.size.height -= (tabBarController?.tabBar.frame.height)!
    
    sentImageCollectionVC = SentImageVC()
    sentImageCollectionVC.view.frame.size.height = collectionContainerView.view.frame.height
    sentImageCollectionVC.sentImageCollection.view.frame.size.height = collectionContainerView.view.frame.height
    sentImageCollectionVC.didMove(toParentViewController: self)
    
    receivedImageCollectionVC = ReceivedImageVC()
    receivedImageCollectionVC.view.frame.size.height = collectionContainerView.view.frame.height
    receivedImageCollectionVC.receivedImageCollection.view.frame.size.height = collectionContainerView.view.frame.height
    receivedImageCollectionVC.didMove(toParentViewController: self)
    receivedImageCollectionVC.view.isHidden = true
    
    self.addChildViewController(sentImageCollectionVC)
    self.addChildViewController(receivedImageCollectionVC)
    
    collectionContainerView.view.addSubview(sentImageCollectionVC.view)
    collectionContainerView.view.addSubview(receivedImageCollectionVC.view)
    
    self.view.addSubview(galleryTabBar.sentTab)
    self.view.addSubview(galleryTabBar.receivedTab)
    self.view.addSubview(collectionContainerView.view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    prepareView()
  }
  
  func prepareView() {
    let backgroundColor = BackgroundColor(bounds: self.view.bounds)
    self.view.layer.insertSublayer(backgroundColor.prepareGradient(), at: 0)
  }
  
  func showSentImageCollection() {
    self.receivedImageCollectionVC.view.isHidden = true
    self.sentImageCollectionVC.view.isHidden = false
    self.galleryTabBar.sentTab.setTitleColor(UIColor.black, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.gray, for: .normal)
  }
  
  func showReceivedImageCollection() {
    self.receivedImageCollectionVC.view.isHidden = false
    self.sentImageCollectionVC.view.isHidden = true
    self.galleryTabBar.sentTab.setTitleColor(UIColor.gray, for: .normal)
    self.galleryTabBar.receivedTab.setTitleColor(UIColor.black, for: .normal)
  }
}
