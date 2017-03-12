//
//  WishlistCollectionViewCell.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {
  
  var wishView: UIView!
  var text: UILabel!
  
  override func awakeFromNib() {
    prepareWishView()
    prepareText()
    
    wishView.addSubview(text)
    contentView.addSubview(wishView)
  }
  
  func prepareWishView() {
    wishView = UIView(frame: contentView.frame)
    wishView.frame.size.width -= 20
    wishView.frame.origin.x += 10
    wishView.layer.cornerRadius = 5
    wishView.backgroundColor = UIColor.white
  }
  
  func prepareText() {
    text = UILabel()
    text.layer.masksToBounds = true
    // numberOfLines = 0 - needed to break by word
    text.numberOfLines = 4
    // width - needed to break by word
    text.frame.size.width = contentView.bounds.width * 0.75 - 20
    text.frame.origin.x = contentView.bounds.width * 0.25
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // sizeToFit - needed to change bound size according to its content
    text.sizeToFit()
  }
}
