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
  var text: UITextField!
  
  override func awakeFromNib() {
    wishView = UIView(frame: contentView.frame)
    wishView.clipsToBounds = true
    
    text = UITextField(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: 50))
    text.backgroundColor = UIColor.white
    
    wishView.addSubview(text)
    contentView.addSubview(wishView)
  }
}
