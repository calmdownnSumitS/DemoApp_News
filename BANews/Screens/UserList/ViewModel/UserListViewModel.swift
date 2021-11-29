//
//  UserListViewModel.swift
//  BANews
//
//  Created by JustMac on 27/11/21.
//

import Foundation
import Combine
class UserListViewModel: NSObject {
    static let shared: UserListViewModel = UserListViewModel()
    private let DB : DBManager = DBManager.shared
    var reloadUser_table : (()->())? = nil
    private var postRecords: Posts = []{
        didSet{
            reloadUser_table?()
        }
    }
    
    private var post:PostInfoModel? = nil
    private override init() {}
    
    
    func getLoclPosts(){
        self.postRecords = DB.loadLocalPostList()
    }
     func getServerPost() {
        guard postRecords.isEmpty else{return}
        ApiManager.shared.get(url: Posts_URL, params: nil) { (result:Posts?, error:String?) in
            if let records = result {
                self.postRecords = records
                print("==========>",records)
                //Nedd to save in local db
                self.savePosts(with: records)
            }
        }
    }
    
    private func savePosts(with serverPosts:Posts){
        
        for post in serverPosts{
            self.DB.insertPost(with: post)
        }
        
        
        
    }
    
    //MARK:- UITABLE HELPER
    func userlistCount() -> Int{
        self.postRecords.count
    }
    
    func user(at index:Int) -> PostInfoModel{
        return self.postRecords[index]
    }
    
    func setSelectedPost(at index:Int){
        self.post = postRecords[index]
    }
    func getSElectedPost()-> PostInfoModel?{
        return post
    }
    
}
