//
//  ViewController.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import UIKit

final class PhotoCollectionController: UICollectionViewController{
    
    //MARK:- Properties
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let photoCollectionAPI = PhotoAPI()
    
    private let searchAPI = SearchPhotoAPI()
   
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        setupSearchBar()

        setupCollectionView()
        
        photoCollectionAPI.getRequestPhoto(complition: { [weak self] data in
            Session.shared.photoArray = data

            DispatchQueue.main.async {
                
                self?.collectionView.reloadData()
            }
        })
        setupCollectionViewItemSize()
    }
    
    //MARK: - Private
    private func setupCollectionViewItemSize() {
        let customLayout = CollectionLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifire)
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 8, bottom: 10, right: 8)
    }
    
    //MARK:- Action
    var searchisEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchisEmpty
    }
   
    private func setupSearchBar() {
        searchController.searchBar.placeholder = "Поиск"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    //MARK:- UICollectionViewDelegate, UICollectionViewDataSourse
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        if isFiltering {
            return Session.shared.searchPhoto.count
        }
        else {
            return Session.shared.photoArray.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifire, for: indexPath) as? PhotoCollectionCell else {fatalError()}
        
        let data: UIImage
        
        if isFiltering {
            data = Session.shared.searchPhoto[indexPath.row].image
        }
        else {
            data = Session.shared.photoArray[indexPath.row].image
        }
        
        cell.photo.image = data
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var data: FinalPhotoModel
        
        if isFiltering {
            data = Session.shared.searchPhoto[indexPath.row]
        }
        else {
            data = Session.shared.photoArray[indexPath.row]
        }
        
        let profilVC = DetailController()
        
        profilVC.favorite = data
     
        present(profilVC, animated: true, completion: nil)
    }
}

//MARK:- Extension PinterestLayoutDelegate
extension PhotoCollectionController: PinterestLayoutDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        
        if isFiltering {
            return Session.shared.searchPhoto[indexPath.row].image.size.height
        }
        else {
            return Session.shared.photoArray[indexPath.row].image.size.height
        }
    }
}

//MARK:- UISearchBarDelegate
extension PhotoCollectionController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchAPI.getRequestSearchPhoto(searchTerm: searchText) { data in
            Session.shared.searchPhoto = data
            DispatchQueue.main.async {
                
                self.collectionView.reloadData()
            }
        }
    }
}
