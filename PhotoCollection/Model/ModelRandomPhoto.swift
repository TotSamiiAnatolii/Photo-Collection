//
//  Model.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import Foundation
import UIKit

//MARK:- PhotoDTO
typealias PhotoDTO = [PhotoElement]

struct FinalPhotoModel {
    public let image: UIImage
    public let downloads: Int?
    public let name: String
    public let id: String
    public let created_at: String
    public let location: String?
    public var isSelected = false
}

// MARK: - PhotoElement
struct PhotoElement: Codable {
    public let urls: Urls
    public let downloads: Int
    public let user: User
    public let id: String
    public let created_at: String
    public var isSelected: Bool? = false
}

// MARK: - Urls
struct Urls: Codable {
    let small: String
    let thumb: String
    let regular: String
    
}

//MARK: - User
struct User: Codable {
    let id: String?
    let username: String
    let portfolioURL: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case portfolioURL = "portfolio_url"
        case location
    }
}











