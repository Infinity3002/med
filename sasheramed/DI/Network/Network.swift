//
//  Network.swift
//  sasheramed
//
//  Created by Aleksandr on 4/12/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//


import RxSwift
import Alamofire
import Locksmith

public final class Network: Networking {
    
    private let queue = DispatchQueue(label: "Network.Queue", attributes: [])
    
    private var headers = [
        "Content-Type": "application/json"
    ]
    
    init() {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "sasheramed")
        if (dictionary != nil && dictionary!["token"] != nil && (dictionary!["token"] as! String).count > 0)  {
            updateHeader(a: dictionary!["token"] as! String)
        }
    }
    
    public func updateHeader(a: String) {
        headers.updateValue(a, forKey: "Authorization-Token")
    }
    
    public func requestJSON<T : Codable>(_ url: String, method: HTTPMethod = .get, parameters: [String : AnyObject]?, T: T.Type) -> PrimitiveSequence<SingleTrait, T> {
        return Single.create{ sub in
            let request = self.createRequest(url, method: method, parameters: parameters)
            
            if let requestBody = request.request?.httpBody {
                let jsonArray = String.init(data: requestBody, encoding: .utf8)
                NSLog("Data: \(jsonArray ?? "")")
            }
            
            request.response(queue: self.queue, responseSerializer: Alamofire.DataRequest.dataResponseSerializer()) {
                response in
                NSLog("Code:  \(response.response?.statusCode ?? 0)")
                NSLog(String.init(data: response.data!, encoding: .utf8) ?? "")
                
                switch response.result {
                case .success( _): do {
                    if(response.response?.statusCode == 200 || response.response?.statusCode == 201){
                        do {
                            let error = self.checkError(response.data!)
                            if(error?.error == nil) {
                                sub(.success(try JSONDecoder().decode(T.self, from: response.data!)))
                            } else {
                                 sub(.error(ValidationError(error!.error!)))
                            }
                        } catch {
                            NSLog("Network.class \(error)")
                            sub(.error(error))
                        }
                    } else {
                        let e = NetworkError(error: NSError(domain: NetworkError.HTTPErrors.domain, code: response.response!.statusCode))
                        sub(.error(e))
                    }
                    }
                case .failure(let error): do {
                    NSLog("Network.class \(error)")
                    sub(.error(error))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func checkError(_ data: Data) -> ErrorResponce?{
        var error: ErrorResponce?
        do {
            error = try JSONDecoder().decode(ErrorResponce.self, from: data)
        } catch {
        }
        return error
    }
    
    private func createRequest(_ url: String, method: HTTPMethod, parameters: [String : AnyObject]?) -> DataRequest {
        
        var paramsBuilder: String = ""
        parameters?.forEach({p in paramsBuilder += "    \(p.key) : \(p.value) \n" })
        NSLog("Network:\n   \(method): \(url)\nheaders:\n\(self.headers)\nparameters:\n\(paramsBuilder)")
  
        if(method == HTTPMethod.get) {
            return Alamofire.request(url, method: method, parameters: parameters, headers: self.headers)
        } else {
            return Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: self.headers)
        }
    }
}

public protocol Networking{
    
    func requestJSON<T : Codable>(_ url: String, method: HTTPMethod, parameters: [String: AnyObject]?, T: T.Type) -> Single<T>
    
    func updateHeader(a: String)
}
