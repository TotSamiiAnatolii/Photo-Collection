//
//  ProfilePhotoView.swift
//  PhotoCollection
//
//  Created by APPLE on 01.05.2022.
//

import UIKit

final class DetailView: UIView {

    //MARK:- Properties
    var onAction: (() -> Void)?
    var onBackButton: (()-> Void)?
  
    private let photo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
     let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.addTarget(self, action: #selector(likeButtomAction), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    private let buttonPanelView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.5
        view.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- View hierarhies
    private func setupView() {
        self.addSubview(likeButton)
        self.addSubview(nameLabel)
        self.addSubview(dateLabel)
        self.addSubview(locationLabel)
        self.addSubview(downloadsLabel)
        self.addSubview(photo)
        photo.addSubview(buttonPanelView)
        self.addSubview(backButton)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            photo.leftAnchor.constraint(equalTo: self.leftAnchor),
            photo.rightAnchor.constraint(equalTo: self.rightAnchor),
            photo.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            downloadsLabel.leftAnchor.constraint(equalTo: locationLabel.leftAnchor),
            downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            likeButton.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            buttonPanelView.widthAnchor.constraint(equalToConstant: 30),
            buttonPanelView.heightAnchor.constraint(equalToConstant: 30),
            buttonPanelView.topAnchor.constraint(equalTo: backButton.topAnchor),
            buttonPanelView.leftAnchor.constraint(equalTo: backButton.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    //MARK:- Action
    @objc func likeButtomAction() {
        onAction?()
    }
    
    @objc func backButtonAction() {
        onBackButton?()
    }
    
    private func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "RUS")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let currentDate = dateFormatter.date(from: date)
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: currentDate!)
    }
    
    public func configureLikeButton(isSelected: Bool) {
        switch isSelected {
        case true:
            likeButton.setImage(UIImage(named: "Like"), for: .normal)
        case false:
            likeButton.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    //MARK:- Public
    public func configureView(model: FinalPhotoModel, image: UIImage, isSelected: Bool) {
        photo.image = image
        configureLikeButton(isSelected: isSelected)
        nameLabel.text = model.name
        dateLabel.text = formatDate(date: model.created_at)
        locationLabel.text = model.location
        downloadsLabel.text = "Downloads: \((model.downloads) ?? 0)"
    }
}
