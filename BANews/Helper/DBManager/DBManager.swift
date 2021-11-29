
//
//  DBManager.swift
//  RegisterDemo
//
//  Created by JustMac on 24/11/21.
//

import UIKit
import FMDB

class DBManager: NSObject {
    static let shared: DBManager = DBManager()
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
        print("DBpath----->",pathToDatabase)
    }
    
    
    
    func createDatabase(tabel WithQuery:String) {
        
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createUsersTableQuery = WithQuery
                    
                    do {
                        try database.executeUpdate(createUsersTableQuery, values: nil)
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
      //  }
      
    }
    
    
    private func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    
    func insertPost(with userData:PostInfoModel) {
        if openDatabase() {
            do
             {
                try database!.executeUpdate("INSERT INTO Post (\(PostColumn.Post_ID.rawValue), \(PostColumn.User_ID.rawValue), \(PostColumn.Title.rawValue), \(PostColumn.BodeMsg.rawValue)) VALUES (?, ?, ?, ?)", values:
                                                [userData.postId ?? 0,
                                                 userData.userID ?? 0,
                                                 userData.title ?? "",
                                                 userData.body ?? ""]
                )
             }
            catch
            {
                print("error \(error)")
            }
            
            database.close()
        }else{
            print("DB Closed")
        }
    }
    
    
    
    func insertUser(with userData:UserDetailModel) {
        if openDatabase() {
            do
          {
            try database!.executeUpdate("INSERT INTO UserDetails (\(UserColumn.ID.rawValue), \(UserColumn.Name.rawValue),\(UserColumn.Address.rawValue), \(UserColumn.Company_Name.rawValue), \(UserColumn.Email.rawValue), \(UserColumn.Number.rawValue)) VALUES (?, ?, ?, ?,?,?)", values: [userData.id ?? 0,userData.name ?? "",userData.address?.city ?? "",userData.company?.name ?? "",userData.email ?? "",userData.phone ?? ""]
            )
          }
            catch
            {
                print("error \(error)")
            }
            database.close()
        }else{
            print("DB Closed")
        }
    }
    
    
    
    func loadLocalPostList() -> Posts {
        var locat_posts: Posts = []
        
        if openDatabase() {
            let query = "select * from Post order by \(PostColumn.Post_ID.rawValue) asc"
            
            do {
                let results = try database.executeQuery(query, values: nil)
                
                while results.next() {
                    let rawPost = PostInfoModel(userID: Int(results.int(forColumn: PostColumn.User_ID.rawValue)),
                                                postId:  Int(results.int(forColumn: PostColumn.Post_ID.rawValue)),
                                                title: results.string(forColumn: PostColumn.Title.rawValue) ?? "",
                                                body: results.string(forColumn: PostColumn.BodeMsg.rawValue) ?? "")
                    
                    locat_posts.append(rawPost)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return locat_posts
    }
    
    
    func loadUser(withID ID: Int, completionHandler: (_ userInfo: UserDetailCellModel?) -> Void) {
        var resultUser: UserDetailCellModel?  = nil
        
        if openDatabase() {
            let query = "select * from UserDetails where \(UserColumn.ID.rawValue)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                    resultUser = UserDetailCellModel(id: Int(results.int(forColumn: UserColumn.ID.rawValue)),
                                                     email: results.string(forColumn: UserColumn.Email.rawValue) ?? "",
                                                     name: results.string(forColumn: UserColumn.Name.rawValue) ?? "",
                                                     address: results.string(forColumn: UserColumn.Address.rawValue) ?? "",
                                                     phone: results.string(forColumn: UserColumn.Number.rawValue) ?? "",
                                                     company: results.string(forColumn: UserColumn.Company_Name.rawValue) ?? "")
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
        completionHandler(resultUser)
    }
    
    
    
    
}
