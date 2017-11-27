//
//  ViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 25/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import Firebase

class ArticlesTableViewController: UITableViewController {
    // Properties
    var articles = [Article]()
    var searchResults = [Article]()
    var isSearch: Bool = false

    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.autocapitalizationType = .none
        tf.placeholder = "🔍 Author Name"
        tf.textAlignment = .center
        if let tfWitdth = self.navigationController?.navigationBar.frame.width,
            let tfHeight = self.navigationController?.navigationBar.frame.height {
            tf.frame = CGRect(x: 0, y: 0, width: tfWitdth * 0.6, height: tfHeight * 0.8)
        } else {
            tf.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        }
        tf.delegate = self
        //tf.becomeFirstResponder()
        return tf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        setUpTableView()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: .handleLogout)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "➕", style: .plain, target: self, action: #selector(handlePost))

        navigationItem.titleView = self.searchTextField

        // If user is logged in or not
        if Auth.auth().currentUser?.uid == nil {
            performSelector(onMainThread: #selector(handleLogout), with: nil, waitUntilDone: false)
        }

        //searchAuthor()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isSearch = false
        getAllArticles()
    }
}
extension ArticlesTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.isSearch = true
        print(self.isSearch)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        searchTextField.addSubview(activityIndicator)
        activityIndicator.frame = searchTextField.bounds
        activityIndicator.startAnimating()

        let searchText = searchTextField.text ?? ""
        self.searchAuthor(authorName: searchText)

        searchTextField.text = nil
        searchTextField.resignFirstResponder()
        activityIndicator.stopAnimating()
        return true
    }
}
extension ArticlesTableViewController {
    @objc func handleLogout() {

        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }

        let landingController = LandingViewController()
        present(landingController, animated: true, completion: nil)
    }

    @objc func handlePost() {
        let postViewController = PostViewController()
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

    func getAllArticles() {
        articles = [Article]()
        let databaseURL: String = "https://articlesystem-c457c.firebaseio.com/"
        let ref = Database.database().reference(fromURL: databaseURL)
        let articlesReference = ref.child("articles")
        articlesReference.queryOrderedByKey().observeSingleEvent(of: .value) { (snapShot) in
            guard let snapShotData = snapShot.value as? [String: AnyObject] else { return }
            for (articleID, articleData) in snapShotData {
                let id = articleID
                guard let authorName = articleData["authorName"] as? String else { return }
                guard let content = articleData["content"] as? String else { return }
                guard let date = articleData["date"] as? String else { return }
                guard let title = articleData["title"] as? String else { return }
                guard let authorID = articleData["authorID"] as? String else { return }
                let article = Article(authorID: authorID, articleID: id, title: title, content: content, date: date, author: authorName)
                self.articles.append(article)
                self.tableView.reloadData()
            }
        }
    }

    func searchAuthor(authorName: String) {
        searchResults = [Article]()
        let searchForName = authorName
        let databaseURL: String = "https://articlesystem-c457c.firebaseio.com/"
        let ref = Database.database().reference(fromURL: databaseURL).child("articles").queryOrdered(byChild: "authorName").queryEqual(toValue: searchForName)
        ref.observe(.value, with: { (snapshot: DataSnapshot) in
            guard let snapShotData = snapshot.value as? [String: AnyObject] else { return }
            for (articleID, articleData) in snapShotData {
                let id = articleID
                guard let authorName = articleData["authorName"] as? String else { return }
                guard let content = articleData["content"] as? String else { return }
                guard let date = articleData["date"] as? String else { return }
                guard let title = articleData["title"] as? String else { return }
                guard let authorID = articleData["authorID"] as? String else { return }
                let article = Article(authorID: authorID, articleID: id, title: title, content: content, date: date, author: authorName)
                self.searchResults.append(article)
            }
            self.tableView.reloadData()
        })
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard section == 0 else { return nil } // Can remove if want button for all sections

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 40))
        let myButton = UIButton(type: .custom)

        myButton.setTitle("Show all articles", for: .normal)
        myButton.addTarget(self, action: #selector(showAllArticles(_:)), for: .touchUpInside)
        myButton.backgroundColor = UIColor.Customs.kiwi
        myButton.setTitleColor(UIColor.white, for: .normal) //set the color this is may be different for iOS 7
        myButton.frame = footerView.frame //set some large width to ur title
        footerView.addSubview(myButton)
        return footerView

    }

    @objc func showAllArticles(_ sender: AnyObject) {
        self.getAllArticles()
        self.isSearch = false
    }
}

extension ArticlesTableViewController {
    func setUpTableView() {

        let nib = UINib(
            nibName: "ArticlesTableViewCell",
            bundle: nil
        )

        tableView.register(
            nib,
            forCellReuseIdentifier: "ArticlesTableViewCell"
        )
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearch == false {
            return self.articles.count
        } else {
            return self.searchResults.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell") as? ArticlesTableViewCell else { return UITableViewCell() }
        if self.isSearch == false {
            if self.articles.count > indexPath.row {
                let article = self.articles[indexPath.row]

                cell.titleLabel.text = article.title
                cell.contentLabel.text = article.content
                cell.dateLabel.text = article.date
                cell.authorLabel.text = article.author

                cell.likeButton.addTarget(self, action: #selector(tapLikeButton(sender:)), for: .touchUpInside)

                return cell
            }
        } else {
            print("here")
            if self.searchResults.count > indexPath.row {
                let article = self.searchResults[indexPath.row]

                cell.titleLabel.text = article.title
                cell.contentLabel.text = article.content
                cell.dateLabel.text = article.date
                cell.authorLabel.text = article.author

                cell.likeButton.addTarget(self, action: #selector(tapLikeButton(sender:)), for: .touchUpInside)

                return cell
            }
        }
        return cell

    }
}
extension ArticlesTableViewController {
    @objc func tapLikeButton(sender: UIButton) {
        guard let cell = sender.superview?.superview as? ArticlesTableViewCell else {
            print("Cell is not in collectioView")
            fatalError()
        }

        guard let indexPath = tableView.indexPath(for: cell) else {
            print("No indexPath")
            return
        }
        let index = indexPath.row

    }
}
extension Selector {
    static let handleLogout = #selector(ArticlesTableViewController.handleLogout)
}

struct Article {
    let authorID: String
    let articleID: String
    let title: String
    let content: String
    let date: String
    let author: String
}
