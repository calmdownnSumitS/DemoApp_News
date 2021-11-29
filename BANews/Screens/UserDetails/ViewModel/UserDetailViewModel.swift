//
//  UserDetaulViewModel.swift
//  BANews
//
//  Created by JustMac on 27/11/21.
//

import Foundation
class UserDetailViewModel : NSObject{
    static let shared : UserDetailViewModel = UserDetailViewModel()
    var reloadUser_table : (()->())? = nil
       private var user: UserDetailModel? = nil{
           didSet{
            print("---------RELoad CALL--------")
               reloadUser_table?()
           }
       }
    var post : PostInfoModel?  {
        return UserListViewModel.shared.getSElectedPost() ?? nil
    }
    private override init() {}
    

    func selectedPostInfo(){
        
        ApiManager.shared.get(url: "\(User_Url)\(String(describing: post?.userID ?? 0))",params: nil) { (result:UserDetailModel?, error:String?) in
            if let s_user = result {
                print("RECIVED MODEL")
                self.user = s_user
            }else{
                print("FAIL TO GET RESULT")
                return
            }
        }
    }
    
  
    
    func getPost() -> PostInfoModel?{
        return post
        
    }
    
    func getUser() -> UserDetailModel?{
        return user
        
    }
}
