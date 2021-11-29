//
//  SQLQuerys.swift
//  BANews
//
//  Created by JustMac on 29/11/21.
//

import Foundation

struct SQLQuerys {
    static var createPostTable:String {
        
        return "create table if not exists Post (\(PostColumn.Post_ID.rawValue) integer primary key autoincrement not null,\(PostColumn.User_ID.rawValue) text not null, \(PostColumn.Title.rawValue) text not null,\(PostColumn.BodeMsg.rawValue) text not null)"

    }
    static var cretaeUserTabel:String {
        return "create table if not exists UserDetails (\(UserColumn.ID.rawValue) integer primary key autoincrement not null,\(UserColumn.Name.rawValue) text not null, \(UserColumn.Company_Name.rawValue) text not null,\(UserColumn.Address.rawValue) text not null, \(UserColumn.Email.rawValue) text not null,\(UserColumn.Number.rawValue) text not null)"
                   }

}

