//
//  NetCom.swift
//  MovieApp
//
//  Created by Lalit Kant on 19/04/21.
//

import Foundation

// This is reusable network class to call the api and return generic data. We can modify this call to inclide headers to api call
final class NetCom {
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T?, Error>) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(.success(objects))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
