//
//  WishlistEntity.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistEntity {

  let id: Int
  let votes: Int
  let description: String
  
  init(id: Int, votes:Int, description: String) {
    self.id = id
    self.votes = votes
    self.description = description
  }
}
