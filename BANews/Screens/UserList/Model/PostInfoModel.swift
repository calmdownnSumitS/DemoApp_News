//
//  PostInfoModel.swift
//  BANews
//
//  Created by JustMac on 26/11/21.
//

import Foundation


struct PostInfoModel: Codable {
    let userID, postId: Int?
    let title, body: String?
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case postId = "id"
        case title = "title"
        case body = "body"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decodeIfPresent(Int.self, forKey: .userID) ?? 0
        self.postId = try container.decodeIfPresent(Int.self, forKey: .postId) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.body = try container.decodeIfPresent(String.self, forKey: .body) ?? ""
        
    }
    init( userID:Int, postId: Int, title:String, body: String) {
        
        self.userID = userID
        self.postId = postId
        self.title = title
        self.body = body

    }
}
typealias Posts = [PostInfoModel]



