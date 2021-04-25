//
//  WebServices.swift
//  sidelineswap
//
//  Created by Danesh Rajasolan on 2021-04-23.
//

import Foundation

enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

class WebServices {
    
    func callItemsAPI<T: Codable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else { completion(.failure(error!)); return }
            do {
                let items = try JSONDecoder().decode(T.self, from: data)
                completion(.success(items))
            } catch {
                print("an error occurred: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (Data?) -> Void) {
        // for asynchronous online image download
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { completion(nil); return }
            completion(data)
        }.resume()
    }
}
