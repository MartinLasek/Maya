//
//  WishlistTableViewCell.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

  var wishDescription: UILabel!
  var wishVotes: UILabel!
  var wishIsVoted = false
  var wishId = 0
  
  init(bounds: CGRect, reuseIdentifier: String) {
    super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
    
    self.wishVotes = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.width * 0.25, height: bounds.height))
    self.wishVotes.textAlignment = .center
    self.wishDescription = UILabel()
    self.wishDescription.frame.size.width = bounds.width * 0.75
    self.wishDescription.frame.origin.x = bounds.width * 0.25
    self.wishDescription.numberOfLines = 0
    
    
    self.contentView.addSubview(self.wishVotes)
    self.contentView.addSubview(self.wishDescription)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
}
