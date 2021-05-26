//
//  MoneyOrderViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/26.
//

import Foundation
import UIKit

class MoneyOrderViewCell:UITableViewCell{
    
    @IBOutlet weak var madeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var hadLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.madeLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.madeLabel.textColor = hexStringToUIColor(hex: "BABABD")
        self.moneyLabel.font = UIFont(name: "Comfortaa-Bold", size: 20)
        self.totalLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.totalLabel.textColor = hexStringToUIColor(hex: "BABABD")
        self.hadLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.hadLabel.textColor = hexStringToUIColor(hex: "BABABD")
        self.orderNumLabel.font = UIFont(name: "Comfortaa-Bold", size: 20)
        self.ordersLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.ordersLabel.textColor = hexStringToUIColor(hex: "BABABD")
        
        self.contentView.addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.topAnchor.constraint(equalTo:topAnchor, constant: 0),
            topSeperator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15),
            topSeperator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topSeperator.widthAnchor.constraint(equalToConstant: 0.5)
            ])
    }
}
