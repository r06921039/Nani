//
//  LogoutViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/26.
//

import Foundation
import UIKit

class LogoutViewCell:UITableViewCell{
    
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var logoutIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.logoutLabel.font = UIFont(name: "Comfortaa-Bold", size: 20)
        self.logoutLabel.textColor = hexStringToUIColor(hex: "FF3D00")
        self.logoutIcon.image = UIImage(named: "power_settings_new_black_24dp.emf")
    }
    
}
