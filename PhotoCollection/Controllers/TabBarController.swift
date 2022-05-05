//
//  TabBarController.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(rootViewController: PhotoCollectionController(collectionViewLayout: UICollectionViewLayout()), image: #imageLiteral(resourceName: "photoCollection")),
            createViewController(rootViewController: FavoriteController(), image: #imageLiteral(resourceName: "heart"))
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBar.barTintColor = .white
    }
    
    //MARK:- Create UIViewController
    func createViewController(rootViewController: UIViewController, image: UIImage) -> UIViewController {
        let viewController = UINavigationController(rootViewController: rootViewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.image = image
        viewController.tabBarItem = tabBarItem
        viewController.tabBarItem.title = title
        return viewController
    }
}
