//
//  WalletManager.swift
//  LeagueWallet
//
//  Created by Carl Udren on 5/25/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation

class CardManager {
    
    //Create singleton
    static let sharedInstance = CardManager(webService: WebServices())
    
    var cards: [Card] = [Card]()
    let webService: WebServices
    
    init(webService: WebServices) {
        self.webService = webService
    }
    
    func fetchRemoteData(success: @escaping ([Card])->Void, failure: @escaping (String)->Void) {
        let session = URLSession.shared
        if let url = URL(string: APIEndpoints.walletEndpoint) {
            webService.makeAPICall(session: session, url: url, apiCallSucceeded: { (json) in
                self.cards = self.parseJSON(json)
                success(self.cards)
            }) { (errorMessage) in
                failure(errorMessage)
            }
        }
    }
    
    internal func parseJSON(_ input: Any) -> [Card] {
        var cardsArray = [Card]()
        let dateFormatter = DateFormatter()
        
        if let inputDict = input as? Dictionary<String, Dictionary<String, Any>> {
            if let cards = inputDict["info"]?["cards"] as? Array<Dictionary<String,Any>> {
                for card in cards {
                    let id = card["id"] as? String ?? ""
                    let typeRaw: String = card["type"] as? String ?? ""
                    let type = typeRaw.replacingOccurrences(of: "_", with: " ").capitalized
                    let amount = card["amount"] as? Int ?? 0
                    let currency = card["currency"] as? String ?? ""
                    let startString = card["policy_start_date"] as? String ?? ""
                    let endString = card["policy_end_date"] as? String ?? ""
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    
                    let startDate = dateFormatter.date(from: startString) ?? Date()
                    let endDate = dateFormatter.date(from: endString) ?? Date()
                    
                    cardsArray.append(Card(id: id, type: type, amount: amount, currency: currency, startDate: startDate, endDate: endDate))
                    
                }
            }
        }
        return cardsArray
    }
    
}
