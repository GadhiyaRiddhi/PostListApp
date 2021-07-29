//
//  FavPostListingVC.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavPostListingVC: UIViewController {

    //MARK: Variables
    @IBOutlet weak var favPostTableView: UITableView!
    var favourites:[PostData]!
    let disposeBag = DisposeBag()
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favPostTableView.separatorStyle = .singleLine

        self.favourites = UserDefaults.standard.value(forKey:"FvrtList") as? [PostData]
        let fvrtData = UserDefaults.standard.data(forKey: "FvrtList")
        self.favourites = try! JSONDecoder().decode([PostData].self, from: fvrtData!)
        self.setUpTableViewData()
    }
    
    func setUpTableViewData()
    {
        //data fill
        let items : Observable<[PostData]> = Observable.just(self.favourites)
        items
            .bind(to: favPostTableView.rx.items(cellIdentifier: "fvrtCell", cellType: PostDataCell.self)) { (row, post, cell) in
                cell.postTitleLbl.text = post.title
                cell.postDescriptionLbl.text = post.body
            }
            .disposed(by: disposeBag)
    }
    
}
