//
//  APIManager.swift
//


import Foundation
import Alamofire
import UIKit
import AlamofireNetworkActivityLogger
class ApiManager:NSObject{
    
    static let shared = ApiManager()
    private override init() {
    }
    
  
    
    static var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    

    
    // get
    func get<T:Codable>(url:String,params:[String:Any]?, heaader:HTTPHeaders? = nil ,encoding :URLEncoding = .default,completion: @escaping (T?, _ error:String?) -> ()) {
        
        if ApiManager.isConnectedToInternet == false {
            completion(nil,ErrorMessages.no_internet)
            return
        }
        DispatchQueue.main.async{
            
            // CommonLoader.shared.active_with(value: true)
            AF.request(url, method: .get, parameters: params, encoding:encoding, headers: heaader)
                .responseData { (response) in
                
                    switch response.result {
                    case .success(let data):
                        do {
                            let model = try JSONDecoder().decode(T.self, from: data)
                            
                            
                            completion(model,nil)
                        } catch let jsonErr {
                            completion(nil,jsonErr.localizedDescription)
                        }
                    case .failure(let err):
                        completion(nil,err.localizedDescription)
                    }
                }
        }
    }


}

struct ErrorMessages {
    static let serverError = "We're having trouble with our server.\nPlease check back after some time."
    static let commonError = "Something went wrong.\nPlease check back after some time."
    static let no_data = "no_data"
    static let no_tags = "no_tags"
    static let no_internet = "You are not connected to the internet."
}
extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}
