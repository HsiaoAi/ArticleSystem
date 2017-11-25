//
//  ViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 25/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .handleLogout)
    }
}
extension ArticlesTableViewController {
    @objc func handleLogout() {

    }
}
extension Selector {
    static let handleLogout = #selector(ArticlesTableViewController.handleLogout)
}
