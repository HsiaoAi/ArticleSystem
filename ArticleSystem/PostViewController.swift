//
//  PostViewController.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 27/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework

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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupSubviews()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }

    override func viewWillLayoutSubviews() {
        setupLayout()
    }

}
extension PostViewController: UITextFieldDelegate {

}

extension PostViewController {
    @objc func handleSave() {
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
