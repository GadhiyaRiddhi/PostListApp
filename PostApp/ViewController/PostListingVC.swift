//
//  PostListingVC.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import UIKit
import RxCocoa
import RxSwift

class PostListingVC: UIViewController {
    
    //MARK: Variables
    @IBOutlet weak var postTableView: UITableView!
    var viewModel: PostListViewModel!
    var postListData:[PostData]!
    var fvrtPostData:[PostData] = []
    let disposeBag = DisposeBag()
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.postTableView.separatorStyle = .singleLine
        viewModel = PostListViewModel()
        viewModel.getPostListFromAPI()
        self.setUpTableViewData()
    }
    
    //MARK: Setup tableview Methods
    
    
    func setUpTableViewData()
    {
        //data fill
        viewModel.listOfPosts
//        let items : Observable<[PostData]> = Observable.just(self.postListData)
//        items
            .bind(to: postTableView.rx.items(cellIdentifier: "PostDataCell", cellType: PostDataCell.self)) { (row, post, cell) in
                cell.postTitleLbl.text = post.title
                cell.postDescriptionLbl.text = post.body
//                cell.favouriteImgView.image = post.isfv == false ? UIImage(named: "Non-Fvrt") : UIImage(named: "favourites")
            }
            .disposed(by: disposeBag)
        //selection
        postTableView.rx.itemSelected
            .subscribe({ [weak self] indexPath in
                self?.viewModel.markFavouritePost(indexPath: indexPath, listType: .AllPosts)
            }).disposed(by: disposeBag)
    }
    
//    func markPostAsFavourite(selectedRow: IndexPath){
//        let selectedPost : PostData = self.postListData[selectedRow.row]
//        selectedPost.isFavourite = selectedPost.isFavourite == false ? true : false
//
//        let cell = self.postTableView.cellForRow(at: selectedRow) as? PostDataCell
//        cell!.favouriteImgView.image = selectedPost.isFavourite == false ? UIImage(named: "Non-Fvrt") : UIImage(named: "favourites")
//
//        if selectedPost.isFavourite == true{
//            self.fvrtPostData.append(selectedPost)
//            let fvrtData = try! JSONEncoder().encode(self.fvrtPostData)
//            UserDefaults.standard.set(fvrtData, forKey: "FvrtList")
//        }
//        else{
//        }
//    }
}
