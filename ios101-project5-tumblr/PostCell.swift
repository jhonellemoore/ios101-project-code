//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Jhonelle Moore on 10/15/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var PostImageView: UIImageView!
    
    @IBOutlet weak var PostSummary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
