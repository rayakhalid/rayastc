//
//  Service.swift
//  stc challenge
//
//  Created by Raya Khalid on 14/11/2021.
//


import Foundation

class Service {
    static let shared = Service()
    
    func getResults(description: String, location: String, completed: @escaping (Result<[Results], ErrorMessage>) -> Void) {
        
        let urlString = "https://jobs.github.com/positions.json?description=\(description.replacingOccurrences(of: " ", with: "+"))&location=\(location.replacingOccurrences(of: " ", with: "+"))"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let deconder = JSONDecoder()
                deconder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try deconder.decode([Results].self, from: data)
                completed(.success(results))
                
                
            } catch {
                completed(.failure(.invalidData))
            }
            
            
        }
        task.resume()
        
        
        
    }
}

enum ErrorMessage: String, Error {
    case invalidData = "Sorry. Somthing went wrong, try again"
    case invalidResponse = "Server error. Please modify your search and try again"
}
