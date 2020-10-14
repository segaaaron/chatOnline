//
//  NewChatCell.swift
//  chatOnline
//
//  Created by Miguel Angel Saravia Belmonte on 10/7/20.
//  Copyright © 2020 chatOnline. All rights reserved.
//

import UIKit
import SDWebImage

class NewChatCell: UITableViewCell {

    static let identifier = "NewConversationCell"

    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 70,
                                     height: 70)

        userNameLabel.frame = CGRect(x: userImageView.right + 10,
                                     y: 20,
                                     width: contentView.width - 20 - userImageView.width,
                                     height: 50)
    }

    public func configure(with model: SearchResult) {
        userNameLabel.text = model.name
        
        self.userImageView.image = UIImage(named: "user_default")

//        let path = "images/\(model.email)_profile_picture.png"
//        ManageFirebaseApi().downloadURL(for: path, completion: { [weak self] result in
//            switch result {
//                case .success(let url):
//
//                    DispatchQueue.main.async {
//                        self?.userImageView.sd_setImage(with: url, completed: nil)
//                    }
//
//                case .failure(let error):
//                    print("failed to get image url: \(error)")
//            }
//        })
    }


}
