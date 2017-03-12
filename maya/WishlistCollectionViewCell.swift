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
    wishView = UIView(frame: contentView.bounds)
    wishView.frame.size.width -= 10
    wishView.frame.origin.x += 5
    
    text = UILabel()
    text.layer.cornerRadius = 5
    text.layer.masksToBounds = true
    text.backgroundColor = UIColor.white
    // numberOfLines = 0 - needed to break by word
    text.numberOfLines = 0
    // width - needed to break by word
    text.frame.size.width = contentView.bounds.width * 0.75
    
    wishView.addSubview(text)
    contentView.addSubview(wishView)
  }
}
