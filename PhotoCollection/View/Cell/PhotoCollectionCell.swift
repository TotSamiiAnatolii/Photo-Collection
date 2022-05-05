//
//  PhotoCollectionCell.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import UIKit

final class PhotoCollectionCell: UICollectionViewCell {
    
    //MARK:- Properties
    static let identifire = "PhotoCollectionCell"
    
    let photo: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCorenerRadiusCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.frame = bounds
        photo.frame = bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photo.image = nil
    }
    
    //MARK:- View hierarhies
    private func setupView() {
        contentView.addSubview(photo)
    }
    
    private func setupCorenerRadiusCell() {
        let radius: CGFloat = 10
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.masksToBounds = true
    }
}
