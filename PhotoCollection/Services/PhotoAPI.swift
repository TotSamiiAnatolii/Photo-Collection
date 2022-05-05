//
//  PhotoCollectionAPI.swift
//  PhotoCollection
//
//  Created by APPLE on 30.04.2022.
//

import Foundation
import UIKit

struct PhotoAPI {
  
    func getRequestPhoto(complition: @escaping(([FinalPhotoModel])->())) {
        var url = URLComponents()
        url.host = "api.unsplash.com"
        url.path = "/photos/random"
        url.scheme = "https"
        url.queryItems = [URLQueryItem(name: "count", value: "30")]
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
                    let photo = try JSONDecoder().decode(PhotoDTO.self , from: data)
                    var finalPhoto:[FinalPhotoModel] = []
                    photo.forEach {
                        let imageData = try? Data(contentsOf: URL(string: $0.urls.small)!)
                        guard let image = UIImage(data: imageData!) else {return}
                        let photo = FinalPhotoModel(image: image, downloads: $0.downloads, name: $0.user.username,  id: $0.id, created_at: $0.created_at, location: $0.user.location)
                        finalPhoto.append(photo)
                    }
                    
                    complition(finalPhoto)
                    
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}

