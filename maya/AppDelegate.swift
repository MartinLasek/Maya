//
//  AppDelegate.swift
//  maya
//
//  Created by Martin Lasek on 16.02.17.
//  Copyright © 2017 Martin Lasek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let tabBarController = UITabBarController()
    let galleryViewController = GalleryContainerVC()
    let cameraViewController = CameraContainerVC()
    let wishlistViewController = WishlistContainerVC()
    let controllers = [galleryViewController, cameraViewController, wishlistViewController]
    
    tabBarController.tabBar.backgroundColor = UIColor.white
    //tabBarController.tabBar.barTintColor = UIColor.white
    
    galleryViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Gallery-Icon"), tag: 1)
    cameraViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Camera-Icon"), tag: 2)
    wishlistViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Wishlist-Icon"), tag: 3)
    
    // centers tab icons vertically
    for controller in controllers {
      controller.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
    }
    
    tabBarController.viewControllers = controllers
    
    window?.rootViewController = tabBarController
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}
