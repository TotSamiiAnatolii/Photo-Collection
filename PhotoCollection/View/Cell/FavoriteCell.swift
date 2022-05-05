//
//  FavoriteCell.swift
//  PhotoCollection
//
//  Created by APPLE on 03.05.2022.
//

import UIKit

final class FavoriteCell: UITableViewCell {
    
    //MARK:- Properties
    static let identifire = "FavoriteCell"
    
    private let photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingHead
        return label
    }()
    
    //MARK:- Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View hierarhies
    private func setupView() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(photo)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            photo.heightAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            photo.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK:- Configure view
    public func configureView(model: FinalPhotoModel) {
        photo.image = model.image
        nameLabel.text = model.name
    }
}
