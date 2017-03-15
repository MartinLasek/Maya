//
//  WishlistTableViewController.swift
//  maya
//
//  Created by Martin Lasek on 12.03.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class WishlistTableVC: UITableViewController {

  var wishes = [WishlistEntity]()
  let reuseIdentifier = "WishlistCell"
  
  override func viewWillAppear(_ animated: Bool) {
    tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(WishlistTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    
    /** TESTING DATA **/
    for index in 1...23 {
      self.wishes.append(WishlistEntity(id: index, votes: Int(arc4random_uniform(100)), description: "I'd love to have transitions between all view changes and so on you know"))
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return wishes.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cells = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    cells.textLabel?.text = wishes[indexPath.row].description
    cells.textLabel?.numberOfLines = 0
    
    let wishVotes = UILabel(frame: CGRect(x: 0, y: 0, width: cells.contentView.frame.size.width * 0.25, height: cells.contentView.frame.size.height))
    wishVotes.text = String(wishes[indexPath.row].votes)
    wishVotes.textAlignment = .center
    
    cells.accessoryView = wishVotes
    
    return cells
  }
}
