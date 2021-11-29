//
//  DetailInfoCell.swift
//  BANews
//
//  Created by JustMac on 25/11/21.
//

import UIKit

class DetailInfoCell: UITableViewCell {

    @IBOutlet weak var headline_lable : UILabel!
    @IBOutlet weak var body_lable : UILabel!
    var userPost:PostInfoModel? = nil{
            didSet{
                guard let pUser = userPost else {return}
                
                headline_lable.text = pUser.title
                body_lable.text = pUser.body

            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
