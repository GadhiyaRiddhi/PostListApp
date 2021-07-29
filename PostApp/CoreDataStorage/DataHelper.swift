//
//  DataStorageHelper.swift
//  PostsViewer
//
//  Created by keyur.tailor on 26/02/21.
//  Copyright © 2021 keyur.tailor. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum PostListType {
    case AllPosts
    case FavouritePosts
}

final class DataStorageHelper {
    
    private init() { }
    
    static let shared = DataStorageHelper()
    
    func fetchAllPostsFromCoreData() -> [Post] {
        let listOfCoreDataPosts = BehaviorRelay(value: [Post]())
        
        listOfCoreDataPosts.accept([Post]())
        listOfCoreDataPosts.accept(CoreDataStack.shared.fetch())
        
        return listOfCoreDataPosts.value
    }
    
    func fetchFavouritePostsFromCoreData() -> [Post] {
        let listOfCoreDataFavouritePosts = BehaviorRelay(value: [Post]())
        
        let posts = CoreDataStack.shared.fetch()
//        let favPosts = posts.filter {$0.isFvrt}
        
        listOfCoreDataFavouritePosts.accept([Post]())
//        listOfCoreDataFavouritePosts.accept(favPosts)
        
        return listOfCoreDataFavouritePosts.value
    }
    
    func markFavouritePost(indexPath: Event<IndexPath>, listType: PostListType, data: BehaviorRelay<[Post]>) {
        switch indexPath {
        case .next(let value):
            data.value[value.row].isFvrt = !data.value[value.row].isFvrt
            CoreDataStack.shared.saveContext()
        case .error(let error):
            print(error.localizedDescription)
        case .completed:
            print("Completed")
        }
    }
    
    func savePostToCoreData(postObj: PostData) {
//        if (!CoreDataStack.shared.isEntityAttributeExist(id: postObj.title, entityName: "Post")) {
            let post = Post(context: CoreDataStack.shared.context)
            post.title = postObj.title
            post.body = postObj.body
            post.isFvrt = false
            CoreDataStack.shared.saveContext()
//        }
    }
}
