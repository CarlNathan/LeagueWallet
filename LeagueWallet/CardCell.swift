//
//  CardCell.swift
//  LeagueWallet
//
//  Created by Carl Udren on 5/25/17.
//  Copyright © 2017 Carl Udren. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {
    
    let roundedView = UIView()
    let typeLabel = UILabel()
    let balanceLabel = UILabel()
    let amountLabel = UILabel()
    let datesLabel = UILabel()
    
    func configureCell(cardType: String, amount: Int, dateString: String) {
        typeLabel.text = cardType
        amountLabel.text = "$\(amount)"
        datesLabel.text = dateString
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupTypeLabel()
        setupBalanceLabel()
        setupAmountLabel()
        seteupDatesLabel()
    }
    
    internal func setupView() {
        roundedView.backgroundColor = UIColor.gray
        roundedView.layer.cornerRadius = 30
        contentView.addSubview(roundedView)
    }
    
    internal func setupTypeLabel() {
        typeLabel.textAlignment = .center
        typeLabel.font = UIFont.systemFont(ofSize: 22)
        typeLabel.textColor = UIColor.white
        roundedView.addSubview(typeLabel)
    }
    
    internal func setupBalanceLabel() {
        balanceLabel.textAlignment = .center
        balanceLabel.text = "Balance"
        balanceLabel.font = UIFont.systemFont(ofSize: 18)
        balanceLabel.textColor = UIColor.orange
        roundedView.addSubview(balanceLabel)
    }
    
    internal func setupAmountLabel() {
        amountLabel.textAlignment = .center
        amountLabel.textColor = UIColor.white
        amountLabel.font = UIFont.systemFont(ofSize: 40)
        roundedView.addSubview(amountLabel)
    }
    
    internal func seteupDatesLabel() {
        datesLabel.textAlignment = .center
        datesLabel.font = UIFont.systemFont(ofSize: 12)
        datesLabel.textColor = UIColor.white
        roundedView.addSubview(datesLabel)
    }

    override func layoutSubviews() {
        layoutView()
        layoutTypeLabel()
        layoutBalanceLabel()
        layoutAmountLabel()
        layoutDatesLabel()
    }

    internal func layoutView() {
        roundedView.frame = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: contentView.bounds.height - 20)
    }
    
    internal func layoutTypeLabel() {
        typeLabel.frame = CGRect(x: 0, y: 10, width: roundedView.bounds.width, height: 30)
    }
    
    internal func layoutBalanceLabel() {
        balanceLabel.frame = CGRect(x: 0, y: typeLabel.frame.maxY + 20, width: roundedView.bounds.width, height: 30)
    }
    
    internal func layoutAmountLabel() {
        amountLabel.frame = CGRect(x: 0, y: balanceLabel.frame.maxY + 6, width: roundedView.bounds.width, height: 30)
    }
    
    internal func layoutDatesLabel() {
        datesLabel.frame = CGRect(x: 0, y: roundedView.frame.maxY - 40, width: roundedView.bounds.width, height: 30)
    }
    
    
}
