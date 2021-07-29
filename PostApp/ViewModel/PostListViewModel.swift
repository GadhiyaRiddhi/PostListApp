//
//  PostListViewModel.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol PostDetailProtocol:class {
    func getPostListWithDetail(postDetail: [[String: Any]]) -> Void
    func failedToGetPostList() -> Void
}

struct PostListViewModel {
    
    let dataStorage = DataStorageHelper.shared
    let persistenceManager = CoreDataStack.shared
    var disposeBag = DisposeBag()
    
    var listOfPosts = BehaviorRelay(value: [Post]())
    
    init() {
    }
    
    func getPostListFromAPI() {
        APIManager.shared.callGetAPI { (result) in
            switch result {
            case .Success(let data):
                let _ = data.map { DataStorageHelper.shared.savePostToCoreData(postObj: $0) }
            case .Error(let message):
                DispatchQueue.main.async {
                    self.listOfPosts.accept(self.dataStorage.fetchAllPostsFromCoreData())
                    print(message)
                }
            }
        }
    }
    
    func getPosts() {
        self.listOfPosts.accept(dataStorage.fetchAllPostsFromCoreData())
    }
    
    func getFavouritePosts() {
        self.listOfPosts.accept(dataStorage.fetchFavouritePostsFromCoreData())
    }
    
    func markFavouritePost(indexPath: Event<IndexPath>, listType: PostListType) {
        dataStorage.markFavouritePost(indexPath: indexPath, listType: listType, data: self.listOfPosts)
        listType == PostListType.AllPosts ? self.listOfPosts.accept(dataStorage.fetchAllPostsFromCoreData()) : self.listOfPosts.accept(dataStorage.fetchFavouritePostsFromCoreData())
    }
    
}
