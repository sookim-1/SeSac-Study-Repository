//
//  SearchCell.swift
//  Diary-Project
//
//  Created by sookim on 2021/11/03.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont().verdanaBold
        dateLabel.font = UIFont().verdanaBold
        contentLabel.font = UIFont().verdanaBold
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
