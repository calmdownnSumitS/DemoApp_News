//
//  userDetailsCell.swift
//  BANews
//
//  Created by JustMac on 29/11/21.
//

import Foundation
struct UserDetailCellModel: Codable {
    let id:Int?
    let name:String
    let email: String?
    let address: String?
    let phone: String?
    let company: String?
    
    
    init(id:Int, email:String,name:String, address: String, phone:String, company: String) {
        self.id  = id
        self.name = name
        self.email = email
        self.address = address
        self.phone = phone
        self.company = company
    }
}
