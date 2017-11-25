//
//  AppDelegate.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 25/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.rootViewController = UINavigationController(rootViewController: ArticlesTableViewController())
        return true
    }

}
