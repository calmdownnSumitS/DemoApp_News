//
//  DetailProfileCell.swift
//  BANews
//
//  Created by JustMac on 25/11/21.
//

import UIKit
import Kingfisher
class DetailProfileCell: UITableViewCell {
    @IBOutlet weak var user_Img : UIImageView!
    @IBOutlet weak var userName_lable : UnderlinedLabel!
    @IBOutlet weak var email_lable : UnderlinedLabel!
    @IBOutlet weak var address_lable : UnderlinedLabel!
    @IBOutlet weak var phone_lable : UnderlinedLabel!
    @IBOutlet weak var company_lable : UnderlinedLabel!
    
    var user:UserDetailModel? = nil{
        didSet{
            guard let pUser = user else {return}
            userName_lable.text = pUser.name
            email_lable.text = pUser.email
            phone_lable.text = pUser.phone
            
            address_lable.text = "\(pUser.address!.street)" + "\(pUser.address!.suite)" + "\(pUser.address!.city)" + "\(pUser.address!.zipcode)"
            
            company_lable.text = pUser.company?.name
            let url = URL(string: "\(img_url)\(user?.id ?? 0)")
            user_Img.kf.indicatorType = .activity
            user_Img.kf.setImage(with: url)
            

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
