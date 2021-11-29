//
//  TableColumn.swift
//  RegisterDemo
//
//  Created by JustMac on 24/11/21.
//

import Foundation
enum PostColumn:String {
 
    case User_ID
    case Post_ID
    case Title
    case BodeMsg
    
     var getCreateQuery:String {
        return "create table Post (\(PostColumn.User_ID.rawValue)integer primary key autoincrement not null,\(PostColumn.Post_ID.rawValue) text not null, \(PostColumn.Title.rawValue) text not null,\(PostColumn.BodeMsg.rawValue) text not null)"
    }
    
    
}


enum UserColumn:String {
    case ID
    case Name
    case Company_Name
    case Address
    case Email
    case Number
    
    
    var getCreateQuery:String {
        return "create table UserDetails (\(UserColumn.ID.rawValue)integer primary key autoincrement not null,\(UserColumn.Name.rawValue) text not null, \(UserColumn.Company_Name.rawValue) text not null,\(UserColumn.Address.rawValue) text not null), \(UserColumn.Email.rawValue) text not null,\(UserColumn.Number.rawValue) text not null)"
        }
    
}


