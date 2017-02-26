//
//  ImageEntity.swift
//  maya
//
//  Created by Martin Lasek on 23.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

class ImageEntity {
  var image: UIImage
  var name: String
  
  init(image: UIImage, name: String) {
    self.image = image
    self.name = name
  }
  
  static func getImageUrl(imageName: String) -> String {
    return ApiDispatcher.baseUrl + "/images/" + imageName
  }
  
  func rotate(by deg: Double) {
    //Calculate the size of the rotated view's containing box for our drawing space
    let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.image.size.width, height: self.image.size.height))
    let t: CGAffineTransform = CGAffineTransform(rotationAngle: CGFloat(deg) * CGFloat(M_PI / 180))
    rotatedViewBox.transform = t
    
    let rotatedSize: CGSize = rotatedViewBox.frame.size
    
    //Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    
    let bitmap: CGContext = UIGraphicsGetCurrentContext()!
    
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
    
    //Rotate the image context
    bitmap.rotate(by: (CGFloat(deg) * CGFloat(M_PI / 180)))
    
    //Now, draw the rotated/scaled image into the context
    bitmap.scaleBy(x: 1.0, y: -1.0)
    bitmap.draw(self.image.cgImage!, in: CGRect(x: -self.image.size.width / 2, y: -self.image.size.height / 2, width: rotatedSize.height, height: rotatedSize.width))
    
    self.image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
  }
  
  func getImageName() -> String {
    return name
  }
  
  func getImageUrl() -> String {
    return ApiDispatcher.baseUrl + "/images/" + name
  }
}
