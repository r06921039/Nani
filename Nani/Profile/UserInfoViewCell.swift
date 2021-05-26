//
//  UserInfoView.swift
//  Nani
//
//  Created by Jeff on 2021/5/26.
//

import Foundation
import UIKit

class UserInfoViewCell:UITableViewCell{
    
    @IBOutlet weak var addressIcon: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneIcon: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mailIcon: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addressIcon.image = UIImage(named: "star-24px.emf")
        self.addressLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.addressLabel.text = "The House at Cornell Tech 1 E. Loop Rd. Apt 17K"
        self.phoneIcon.image = UIImage(named: "star-24px.emf")
        self.phoneLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.phoneLabel.text = "332-234-22xx"
        self.mailIcon.image = UIImage(named: "star-24px.emf")
        self.mailLabel.font = UIFont(name: "Comfortaa-Bold", size: 15)
        self.mailLabel.text = "contact.nanitoday@gmail.com"
    }
    
}
