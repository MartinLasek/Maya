//
//  ReceivedImageCollectionViewCell.swift
//  maya
//
//  Created by Martin Lasek on 11.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ReceivedImageCollectionViewCell: UICollectionViewCell {
  
  var receivedImageView: UIImageView!
  
  override func awakeFromNib() {
    receivedImageView = UIImageView(frame: contentView.frame)
    receivedImageView.contentMode = .scaleAspectFill
    receivedImageView.clipsToBounds = true
    contentView.addSubview(receivedImageView)
  }
}
