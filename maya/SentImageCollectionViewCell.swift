//
//  SentImageCollectionViewCell.swift
//  maya
//
//  Created by Martin Lasek on 10.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class SentImageCollectionViewCell: UICollectionViewCell {
  
  var sentImageView: UIImageView!
  
  override func awakeFromNib() {
    sentImageView = UIImageView(frame: contentView.frame)
    sentImageView.contentMode = .scaleAspectFill
    sentImageView.clipsToBounds = true
    contentView.addSubview(sentImageView)
  }
}
