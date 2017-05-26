//
//  DataModel.swift
//  LeagueWallet
//
//  Created by Carl Udren on 5/25/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation


struct Card {
    init (id: String, type: String, amount: Int, currency: String, startDate: Date, endDate: Date) {
        self.id = id
        self.type = type
        self.amount = amount
        self.currency = currency
        self.policyStartDate = startDate
        self.policyEndDate = endDate
    }
    let id: String
    let type: String
    let amount: Int
    let currency: String
    let policyStartDate: Date
    let policyEndDate: Date
    
}
