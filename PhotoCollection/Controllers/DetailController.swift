//
//  ProfilPhoto.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import UIKit

protocol WorkWithFavorite {
    func reload()
}

class DetailController: UIViewController {
    
    //MARK:- Properties
    private var profileView: DetailView {self.view as! DetailView}
    var onFinish: ((PhotoElement)->())?
    var favorite: FinalPhotoModel!
    var delegate: WorkWithFavorite?
   
    //MARK:- Lifecycle
    override func loadView() {
        super.loadView()
        self.view = DetailView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        profileView.onAction = {
            self.likeButton()
        }
        profileView.onBackButton = {
            self.backButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.profileView.configureView(model: favorite, image: favorite.image, isSelected: favorite.isSelected)
    }
    
    //MARK:- Action
    private func addFavorite(photo: FinalPhotoModel) {

        switch Session.shared.favoriteArray.isEmpty {
        case true:
            Session.shared.favoriteArray.append(photo)
        case false:
            if !Session.shared.favoriteArray.contains(where: {$0.id == photo.id}){
                Session.shared.favoriteArray.append(photo)
            }
        }
    }
    
    private func deleteFavorite(id: String) {
        let indexPhoto = Session.shared.favoriteArray.firstIndex{$0.id == id}
        guard let index = indexPhoto else {return}
        Session.shared.favoriteArray.remove(at: index)
    }
    
    private func updateIsSelected(id: String, isSelected: Bool) {
        let indexPhoto = Session.shared.photoArray.firstIndex{$0.id == id}
        guard let index = indexPhoto else {return}
        Session.shared.photoArray[index].isSelected = isSelected
    }
    
    //MARK:- Action
    private func likeButton() {
        let select = favorite.isSelected == false ? true : false
        favorite.isSelected = select
        profileView.configureLikeButton(isSelected: select)
        updateIsSelected(id: favorite.id, isSelected: select)
        
        switch select {
        case true:
           addFavorite(photo: favorite)
        case false:
            deleteFavorite(id: favorite.id)
            delegate?.reload()
        }
    }
    
    private func backButton() {
        dismiss(animated: true, completion: nil)
    }
}
