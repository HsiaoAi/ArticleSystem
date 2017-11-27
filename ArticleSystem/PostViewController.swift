//
//  PostViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 27/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class PostViewController: UIViewController {

    lazy var titleTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = "Title"
        tf.delegate = self
        tf.layer.borderColor = UIColor.Customs.kiwi.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.font = UIFont.boldSystemFont(ofSize: 20)

        return tf
    }()

    lazy var contentTextField: UITextField = {
        let tf = UITextField()
        tf.autocapitalizationType = .none
        tf.placeholder = "Article Content"
        tf.textAlignment = .natural
        tf.layer.borderColor = UIColor.Customs.kiwi.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.delegate = self
        tf.textAlignment = .left
        tf.contentVerticalAlignment = .top
        return tf
    }()

    var authorName: String?
    var authorID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupSubviews()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))

        getAuthorName()
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }

}
extension PostViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension PostViewController {
    func getAuthorName() {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapShot) in
            guard let dictionary = snapShot.value as? [String: AnyObject] else { return }
            guard let authorFirstName = dictionary["firstName"] as? String else { return }
            guard let authorLasttName = dictionary["lastName"] as? String else { return }
            guard let authorID = snapShot.key as? String else { return }
            self.authorID = authorID
            self.authorName = "\(authorFirstName) \(authorLasttName)"

        })
    }

    func getPostDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }

    @objc func handleSave() {
        guard let title = titleTextField.text else { print(PostError.emptyTitle); return }
        guard let content = contentTextField.text else { print(PostError.emptyContent); return }
        guard let authorName = self.authorName else { return }
        guard let authorID = self.authorID else { return }

        let date = getPostDate()

        let databaseURL: String = "https://articlesystem-c457c.firebaseio.com/"
        let ref = Database.database().reference(fromURL: databaseURL)
        let articlesReference = ref.child("articles").childByAutoId()
        let values: [String: Any] = ["title": title,
                                     "content": content,
                                     "authorName": authorName,
                                     "authorID": authorID,
                                     "date": date]

        articlesReference.updateChildValues(values, withCompletionBlock: { (error, _) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            self.navigationController?.popViewController(animated: true)
        })

    }

    @objc func handleCancel() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PostViewController {
    func setupSubviews() {
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
    }
    func setupLayout() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 84).isActive = true
        titleTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        titleTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true

        contentTextField.translatesAutoresizingMaskIntoConstraints = false
        contentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
        contentTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
        contentTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
}

enum PostError: Error {
    case emptyTitle
    case emptyContent
}

struct Author {
    var id: String
    var name: String
}
