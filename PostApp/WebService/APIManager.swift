//
//  APIManager.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import Alamofire
import MaterialActivityIndicator

class APIManager
{
    static let shared = APIManager()
    static let Sharedndicator = MaterialActivityIndicatorView()
    let serviceURL = "https://jsonplaceholder.typicode.com/posts"
    
    func callGetAPI(completion: @escaping (Reponse<[PostData]>) -> Void)
    {
        if !NetworkReachabilityManager()!.isReachable {
            
        } else {
            self.showActivityIndicator()
            Alamofire.request(serviceURL, method: .get, parameters: nil, encoding: JSONEncoding(), headers: nil).responseJSON { (response) in
                
                if response.result.error != nil {
                    self.hideActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                    guard let data = response.data else { return }
                    do {
                        let decoder = JSONDecoder()
                        let loginRequest = try decoder.decode([PostData].self, from: data)
                        DispatchQueue.main.async {
                            completion(.Success(loginRequest))
                        }
                    } catch let parseError {
                        return completion(.Error(parseError.localizedDescription))
                    }
                }
            }
        }
    }
    
    //MARK: Helper Methods
    func showActivityIndicator() {
        APIManager.Sharedndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            APIManager.Sharedndicator.stopAnimating()
        }
    }
}

enum Reponse<T> {
    case Success(T)
    case Error(String)
}
