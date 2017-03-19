//
//  ApiDispatcher.swift
//  maya
//
//  Created by Martin Lasek on 20.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import Foundation
import UIKit

class ApiDispatcher {
  
  static let baseUrl = "http://192.168.2.141:8080"
  
  /// MARK: Image Api Endpoints
  static let postImageUrl = baseUrl + "/image/new"
  static let getRandomImageUrl = baseUrl + "/image/random"
  static let getSentImagesUrl = baseUrl + "/image/list/sent"
  static let getReceivedImagesUrl = baseUrl + "/image/list/received"
  
  /// MARK: Wish Api Endpoints
  static let getWishlistUrl = baseUrl + "/wish/list"
  static let postWishUrl = baseUrl + "/wish/new"
  static let voteWishUrl = baseUrl + "/wish/vote"
  
  /// Sends taken image as bytes to API
  func postImage(req: SendImageRequest) {
    let url = URL(string: ApiDispatcher.postImageUrl)
    var httpRequest = URLRequest(url: url!)
    var body = Data()
    
    guard let imageData = UIImagePNGRepresentation(req.image) else {
      return
    }
    
    body.append(imageData)
    httpRequest.httpBody = body
    httpRequest.httpMethod = "POST"
    httpRequest.setValue("image/png", forHTTPHeaderField: "Content-Type")
    
    if let phoneUUID = UIDevice.current.identifierForVendor?.uuidString {
      httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest)
    task.resume()
  }
  
  /// Requests a random image from API.
  ///
  /// - parameter complete: closure to be called when image is ready to be displayed
  func getRandomImage(complete: @escaping ((UIImage?) -> ())) {
    let url = URL(string: ApiDispatcher.getRandomImageUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "GET"
    
    if let phoneUUID = UIDevice.current.identifierForVendor?.uuidString {
      httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      
      if let data = data, let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? Dictionary<String, AnyObject> {
        if let imageName = json["image"] as? String {
          do {
            if let url = URL(string: ImageEntity.getImageUrl(imageName: imageName)) {
              let data = try Data(contentsOf: url)
              let image = ImageEntity(image: UIImage(data: data)!, name: imageName)
              image.rotate(by: 90)
              
              complete(image.image)
            }
          } catch {
            return
          }
        }
      }
    }
    
    task.resume()
  }
  
  func getImages(fromUrl: String, complete: @escaping ((String) -> ())) {
    let url = URL(string: fromUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "GET"
    
    if let phoneUUID = UIDevice.current.identifierForVendor?.uuidString {
      httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      
      guard let _:Data = data, let _:URLResponse = response, error == nil else {
        print("error")
        print(error ?? "couldn't print error")
        return
      }
      
      if let data = data, let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String] {
        
        for imageName in json {
          
          complete(imageName)
        }
      }
    }
    
    task.resume()
  }
  
  func getWishlist(complete: @escaping ((WishlistEntity) -> ())) {
    let url = URL(string: ApiDispatcher.getWishlistUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "GET"
    
    if let phoneUUID = UIDevice.current.identifierForVendor?.uuidString {
      httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    }

    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      
      if let data = data, let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [Dictionary<String, AnyObject>] {
        
        for wish in json {
          
          if let wishId = wish["id"] as? Int, let votes = wish["votes"] as? Int, let description = wish["description"] as? String, let userPhoneUUID = wish["userPhoneUUID"] as? String, let isOwner = wish["isOwner"] as? Bool  {
            complete(WishlistEntity(id: wishId, votes: votes, description: description, userPhoneUUID: userPhoneUUID, isOwner: isOwner))
          }
        }
      }
    }

    task.resume()
  }
  
  func postWish(wish: String, complete: @escaping () -> ()) throws {
    let url = URL(string: ApiDispatcher.postWishUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "POST"
    
    guard let phoneUUID = UIDevice.current.identifierForVendor?.uuidString else {
      throw ApiError.couldNotGeneratePhoneUUID
    }
    
    httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    httpRequest.setValue(wish, forHTTPHeaderField: "wish")
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      complete()
    }
    
    task.resume()
  }
  
  func voteWish(wish: WishlistEntity, complete: @escaping () -> ()) throws {
    let url = URL(string: ApiDispatcher.voteWishUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "POST"
    
    httpRequest.setValue(wish.userPhoneUUID, forHTTPHeaderField: "phoneUUID")
    httpRequest.setValue(String(wish.id), forHTTPHeaderField: "wishId")
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      complete()
    }
    
    task.resume()
  }
}
