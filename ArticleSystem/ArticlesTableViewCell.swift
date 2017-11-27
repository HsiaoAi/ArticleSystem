//
//  ArticlesTableViewCell.swift
//  ArticleSystem
//
//  Created by Hsiao Ai LEE on 27/11/2017.
//  Copyright © 2017 Hsiao Ai LEE. All rights reserved.
//

import UIKit
import ChameleonFramework

class ArticlesTableViewCell: UITableViewCell {

    // MARK: Property

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.layer.cornerRadius = 3
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.borderColor = UIColor.Customs.kiwi.cgColor
        contentLabel.layer.cornerRadius = 3
        contentLabel.layer.masksToBounds = true
        contentLabel.layer.borderColor = UIColor.Customs.kiwi.cgColor

        let likeButtonImage = UIImage(named: "icon-heart")?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(likeButtonImage, for: .normal)
        likeButton.tintColor = UIColor.flatGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
