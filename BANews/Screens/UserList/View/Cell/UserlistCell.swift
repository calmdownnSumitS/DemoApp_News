//
//  MainTableViewCell.swift
//  BANews
//
//  Created by JustMac on 24/11/21.
//

import UIKit

class UserlistCell: UITableViewCell {
    // first api
    @IBOutlet private weak var headline_lable : UILabel!
    @IBOutlet private weak var body_lable : UILabel!
  
    //fetch from second api
    @IBOutlet private weak var userName_label : UILabel!
    @IBOutlet private weak var companyName_label : UILabel!
    
    var post:PostInfoModel? = nil{
        didSet{
            guard let postData = post else{return}
            headline_lable.text = postData.title
            body_lable.text = postData.body
            DBManager.shared.loadUser(withID: postData.userID!) { (user) in
                guard let u = user else{
                    loadFromServer(with: postData.userID!)
                    return
                }
                userName_label.text = u.name
                companyName_label.text = u.address
            }
        }
    }
    private func loadFromServer(with Id:Int){
        PostCellViewModel.shared.loadUser(withID: Id) { (user) in
            self.userName_label.text = user?.name ?? "Name"
            self.companyName_label.text = user?.company?.name ?? "Address"
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
