//
//  WebServices.swift
//  LeagueWallet
//
//  Created by Carl Udren on 5/25/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation

class WebServices {
    
    
    func makeAPICall(session: URLSession, url: URL, apiCallSucceeded: @escaping (_ json: Any)->Void, apiCallFailed: @escaping (_ error: String) -> Void) {
        
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                
                //CHECK HTTP RESPONSE
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        
                        //JSON SERIRALIZATION
                        if let d = data {
                            if let json = self.serializeResponseData(d) {
                                DispatchQueue.main.async {
                                    apiCallSucceeded(json)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    apiCallFailed("JSON serialization error")
                                }
                            }
                        }
                        break
                    case 500:
                        DispatchQueue.main.async {
                            apiCallFailed(error?.localizedDescription ?? "Unspecified Error")
                        }
                        break
                    default:
                        break
                    }
                }
            })
            task.resume()
    }
    
    
    internal func serializeResponseData(_ data: Data) -> Any? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            return json
        } catch {
            
            //Handle JSON serialization error.  For brevity this function will return nil if there is an error.
            return nil
        
        }
    }
    
    
}
