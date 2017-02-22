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
  
  func sendImage(req: SendImageRequest) {
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
}
