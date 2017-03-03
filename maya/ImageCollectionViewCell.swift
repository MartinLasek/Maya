//
//  CollectionViewCell.swift
//  maya
//
//  Created by Martin Lasek on 24.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  var sentImageView: UIImageView!
  
  override func awakeFromNib() {
    sentImageView = UIImageView(frame: contentView.frame)
    sentImageView.contentMode = .scaleAspectFill
    sentImageView.clipsToBounds = true
    contentView.addSubview(sentImageView)
  }
}
