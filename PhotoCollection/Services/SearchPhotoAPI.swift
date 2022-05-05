//
//  SearchPhotoAPI.swift
//  PhotoCollection
//
//  Created by APPLE on 04.05.2022.
//

import Foundation
import UIKit

struct SearchPhotoAPI {
    
    public func getRequestSearchPhoto(searchTerm: String, complition: @escaping(([FinalPhotoModel])->())) {
        var url = URLComponents()
        url.host = "api.unsplash.com"
        url.path = "/search/photos"
        url.scheme = "https"
        url.queryItems = [URLQueryItem(name: "query", value: searchTerm),
                          URLQueryItem(name: "per_page", value: "30")]
        
        guard let url = url.url else {fatalError()}
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Session.shared.accesToken
        
        DispatchQueue.main.async {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: request ) {data, response, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200 ... 300 :
                        print("Status: \(response.statusCode)")
                        break
                    default:
                        print("Status: \(response.statusCode)")
                    }
                }
                
                guard let data = data else {return}
                
                do {
                    let photo = try JSONDecoder().decode(SearchPhotoDTO.self , from: data)
                    
                    var fainalSearch: [FinalPhotoModel] = []
                    photo.results.forEach {
                        let imageData = try? Data(contentsOf: URL(string: $0.urls.small)!)
                        guard let image = UIImage(data: imageData!) else {return}
                        let photo = FinalPhotoModel(image: image, downloads: nil, name: $0.user.username, id: $0.id, created_at: $0.createdAt, location: nil)
                        fainalSearch.append(photo)
                    }
                    complition(fainalSearch)
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
