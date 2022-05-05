//
//  Session.swift
//  PhotoCollection
//
//  Created by APPLE on 04.05.2022.
//

import Foundation
import UIKit

final class Session {
    
    private init () {}
    
    static let shared = Session()
    
    var photoArray:[FinalPhotoModel] = []
    
    var searchPhoto:[FinalPhotoModel] = []
    
    var favoriteArray:[FinalPhotoModel] = []
    
    let accesToken = ["Authorization": "Client-ID YmpIt3brV3r3e3q6_7jb0KU6ZB9WqOKCKXndbEVyssA"]
}
