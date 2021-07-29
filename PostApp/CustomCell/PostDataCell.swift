//
//  PostDataCell.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import UIKit

class PostDataCell: UITableViewCell {
    
    
    @IBOutlet weak var postTitleLbl: UILabel!
    @IBOutlet weak var postDescriptionLbl: UILabel!
    @IBOutlet weak var favouriteImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
