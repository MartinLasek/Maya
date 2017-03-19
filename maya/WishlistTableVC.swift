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
    
    fetchWishlist()
  }
  
  func fetchWishlist() {
    let apiDispatcher = ApiDispatcher()
    
    apiDispatcher.getWishlist(complete: { wish in
      
      // adds only wishes to list that don't exist yet
      if !self.wishes.contains(where: { $0.id == wish.id }) {
        self.wishes.append(wish)
        self.wishes.sort { $0.votes > $1.votes }
        
        DispatchQueue.main.async(execute: {
          self.tableView.reloadData()
          
          // needed to fix wrong alignments in some cells
          self.tableView.setNeedsLayout()
          self.tableView.layoutIfNeeded()
        })
      }
      
      // updated votes for a wish
      if self.wishes.contains(where: { $0.votes != wish.votes}) {
        
        for element in self.wishes {
          
          if (element.id == wish.id) {
            element.votes = wish.votes
            self.wishes.sort { $0.votes > $1.votes }
            
            DispatchQueue.main.async(execute: {
              self.tableView.reloadData()
            })
          }
        }
      }
    })
  }
  
  func vote(wish: WishlistEntity) throws {
    
    guard let phoneUUID = UIDevice.current.identifierForVendor?.uuidString else {
      throw WishlistError.couldNotGetPhoneUUID
    }
    
    if wish.userPhoneUUID != phoneUUID {
      let apiDispatcher = ApiDispatcher()
      try apiDispatcher.voteWish(wish: wish, complete: {
        self.fetchWishlist()
      })
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.wishes.count
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    cell.textLabel?.text = wishes[indexPath.row].description
    cell.textLabel?.numberOfLines = 0
    
    let wishVotes = UILabel(frame: CGRect(x: 0, y: 0, width: cell.contentView.frame.size.width * 0.25, height: cell.contentView.frame.size.height))
    wishVotes.text = String(wishes[indexPath.row].votes)
    wishVotes.textAlignment = .center
    
    cell.accessoryView = wishVotes
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    do {
      try self.vote(wish: wishes[indexPath.row])
    } catch {
      return
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
