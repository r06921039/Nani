//
//  ActionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/26.
//

import Foundation
import UIKit

class ActionViewCell:UITableViewCell{
    
    @IBOutlet weak var paymentIcon: UIImageView!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var friendsIcon: UIImageView!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.paymentIcon.image = UIImage(named: "credit_card_black_24dp")
        self.friendsIcon.image = UIImage(named: "people_black_24dp")
        self.settingsIcon.image = UIImage(named: "settings_black_24dp")
        self.paymentLabel.font = UIFont(name: "Comfortaa-Bold", size: 16)
        self.friendsLabel.font = UIFont(name: "Comfortaa-Bold", size: 16)
        self.settingsLabel.font = UIFont(name: "Comfortaa-Bold", size: 16)
    }
}
