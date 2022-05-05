//
//  ModelSearchPhoto.swift
//  PhotoCollection
//
//  Created by APPLE on 03.05.2022.
//

import Foundation

// MARK: - SearchPhoto
struct SearchPhotoDTO: Codable {
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String
    let createdAt: String
    let user: UserSearch
    let urls: UrlsSearch

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case user, urls
    }
}

// MARK: - Urls
struct UrlsSearch: Codable {
    let raw, full, regular, small: String
    let thumb: String
}

// MARK: - User
struct UserSearch: Codable {
    let username: String

    enum CodingKeys: String, CodingKey {
        case username
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let small, medium, large: String
}
