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
  static let postImageUrl = baseUrl + "/image/new"
  static let getRandomImageUrl = baseUrl + "/image/random"
  
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
  /// - parameter complete: closure to be called when image is ready to be display
  func getRandomImage(complete: ((UIImage?) -> ())? = nil) {
    let url = URL(string: ApiDispatcher.getRandomImageUrl)
    var httpRequest = URLRequest(url: url!)
    httpRequest.httpMethod = "GET"
    
    if let phoneUUID = UIDevice.current.identifierForVendor?.uuidString {
      httpRequest.setValue(phoneUUID, forHTTPHeaderField: "phoneUUID")
    }
    
    let session = URLSession.shared
    let task = session.dataTask(with: httpRequest) { (data, response, error) in
      
      if let data = data, let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? Dictionary<String,AnyObject> {
        if let imageName = json["image"] as? String {
          do {
            if let url = URL(string: ImageEntity.getImageUrl(imageName: imageName)) {
              let data = try Data(contentsOf: url)
              let image = ImageEntity(image: UIImage(data: data)!)
              image.rotate(by: 90)
              
              complete?(image.image)
            }
          } catch {
            return
          }
        }
      }
    }
    
    task.resume()
  }
}
