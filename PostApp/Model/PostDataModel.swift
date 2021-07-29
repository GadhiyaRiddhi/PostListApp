//
//  PostDataModel.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation

class PostData: NSObject, Codable {
    
    var title: String = ""
    var body: String = ""
    var isFavourite: Bool = false
    
    init(with Dict:[String:Any]) {
        super.init()
        if let value = Dict["title"] as? String {
            self.title = value
        }
        if let value = Dict["body"] as? String {
            self.body = value
        }
        self.isFavourite = false
        
    }
}

