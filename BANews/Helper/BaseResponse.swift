//
//  BaseResponse.swift
//  BANews
//
//  Created by JustMac on 28/11/21.
//
import Foundation

struct BaseResponse<T>:Codable where T:Codable{
    var statusCode: Int?
    var message:String = ""
    var error:String = ""
    var MessageCode:Int = 0
    var data: T?
    enum CodingKeys: String, CodingKey {
        case statusCode
        case message = "Message"
        case data = "Data"
        case error
        case MessageCode
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        MessageCode = try container.decodeIfPresent(Int.self, forKey: .MessageCode) ?? 0
        statusCode = try container.decodeIfPresent(Int.self, forKey: .statusCode)
        data = try? container.decodeIfPresent(T.self, forKey: .data)
        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
        //expiresAt = try container.decodeIfPresent(String.self, forKey: .expiresAt) ?? ""
        
        if let vl  = try? container.decodeIfPresent(Dictionary<String,String>.self, forKey: .error){
            var output: String = ""
            vl.forEach({output += "\($0.key):\($0.value)\n"})
            error = output
        }else if let vl = try? container.decodeIfPresent(String.self, forKey: .error){
            error = vl
        }else{
            error = message
        }
    }
    
}
