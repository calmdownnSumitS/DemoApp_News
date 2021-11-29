//
//  UserDetailModel.swift
//  BANews
//
//  Created by JustMac on 27/11/21.
//

import Foundation

// MARK: - Welcome
struct UserDetailModel: Codable {
    let id: Int?
    let name, username, email: String?
    let address: Address?
    let phone, website: String?
    let company: Company?
     init(empty:Bool = true)  {
        id = 0
        name = ""
        username = ""
        email = ""
        address = nil
        phone = ""
        website = ""
        company = nil
    }
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}
