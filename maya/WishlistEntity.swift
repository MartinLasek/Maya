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
  var votes: Int
  let description: String
  let userPhoneUUID: String
  let isOwner: Bool
  
  init(id: Int, votes:Int, description: String, userPhoneUUID: String, isOwner: Bool) {
    self.id = id
    self.votes = votes
    self.description = description
    self.userPhoneUUID = userPhoneUUID
    self.isOwner = isOwner
  }
}
