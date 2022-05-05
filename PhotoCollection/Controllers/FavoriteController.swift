//
//  FavoriteController.swift
//  PhotoCollection
//
//  Created by APPLE on 03.05.2022.
//

import UIKit

final class FavoriteController: UITableViewController {
   
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
        tableView.isEditing = false
        navigationBar()
    }
    
    //MARK:- Create alert
    private func showAlert(index: Int, indexPath: IndexPath) {
        let alert = UIAlertController(title: "Удалить", message: "Удалить файл?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
            self.deletePhotoPost(index: index)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
            print("dissmiss")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Setup tableView
    private func setupTableView() {
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifire)
        tableView.separatorStyle = .none
    }
    
    //MARK:- Setup NavigationBar
    private func navigationBar() {
        let editButton = UIBarButtonItem(title: "Редактировать", style: .plain, target: self, action: #selector(editAction))
        self.navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    //MARK:- Action
    @objc func editAction(sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        sender.title = (tableView.isEditing) ? "Готово" : "Редактировать"
    }
    
    private func deletePhotoPost(index: Int) {
        let photoPost = Session.shared.favoriteArray[index]
        let index1 = Session.shared.photoArray.firstIndex{$0.id == photoPost.id}
        Session.shared.photoArray[index1!].isSelected = false
        Session.shared.favoriteArray.remove(at: index)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Session.shared.favoriteArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifire, for: indexPath) as? FavoriteCell else {fatalError()}
        let data = Session.shared.favoriteArray[indexPath.row]
        cell.configureView(model: data)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profilVC = DetailController()
        let data = Session.shared.favoriteArray[indexPath.row]
        present(profilVC, animated: true, completion: nil)
        profilVC.delegate = self
        profilVC.favorite = data
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        
        case .delete:
            
            showAlert(index: indexPath.row, indexPath: indexPath)

        default:
            break
        }
    }
}
extension FavoriteController: WorkWithFavorite {

    func reload() {
        tableView.reloadData()
    }
}
