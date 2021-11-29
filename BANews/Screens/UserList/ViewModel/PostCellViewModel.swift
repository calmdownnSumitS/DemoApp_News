//
//  PostCellViewModel.swift
//  BANews
//
//  Created by JustMac on 29/11/21.
//

import Foundation
class PostCellViewModel: NSObject {
    static  let shared : PostCellViewModel = PostCellViewModel()
    private override init() {    }
    func loadUser(withID ID: Int, completion: @escaping (_ user : UserDetailModel?) -> ()){
        ApiManager.shared.get(url: "\(User_Url)\(ID)",params: nil) { (result:UserDetailModel?, error:String?) in
            if let s_user = result {
                print("RECIVED MODEL")
                DBManager.shared.insertUser(with: s_user)
                completion(s_user)
            }else{
                print("FAIL TO GET RESULT")
                completion(nil)
            }
        }
    }
}
