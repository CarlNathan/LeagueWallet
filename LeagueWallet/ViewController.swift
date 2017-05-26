//
//  ViewController.swift
//  LeagueWallet
//
//  Created by Carl Udren on 5/25/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let cellIdentifier = "WalletCardCell"
    var cards = [Card]()
    let tableView = UITableView()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchData()
        
    }
    
    internal func fetchData() {
        CardManager.sharedInstance.fetchRemoteData(success: { (cards) in
            self.cards = cards
            self.tableView.reloadData()
        }) { (errorMessage) in
            
            // Insert Error handling here.  Inform UI of error.
            
        }
    }
    
    internal func setupTableView() {
        tableView.register(CardCell.self, forCellReuseIdentifier: ViewController.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.frame
        tableView.reloadData()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifier) as! CardCell
        
        let card = cards[indexPath.row]
        dateFormatter.dateFormat = "MMM dd YYYY"
        let startDateString = dateFormatter.string(from: card.policyStartDate)
        let endDateString = dateFormatter.string(from: card.policyEndDate)
        let dateString = "Effective: " + startDateString + " - " + endDateString
        cell.configureCell(cardType: card.type, amount: card.amount, dateString: dateString)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}

