//
//  UserImageCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/25.
//

import Foundation
import UIKit
import Kingfisher

class UserImageCell: UITableViewCell{
    

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefIcon: UIImageView!
    @IBOutlet weak var chefLabel: UILabel!
    @IBOutlet weak var ratingIcon: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var chef: User? {
            didSet {
                print("chef \(chef)")
                userName.text = chef?.name
                chefLabel.text = chef?.chef_label
                chefName.text = "AKA " + (chef?.chef_name ?? "")
                ratingLabel.text = String(chef!.average_rating) + " (" + String(chef!.total_ratings) + ")"
//                infoButton.setImage(chef?.picture, for: .normal)
                if let photourl = chef?.photoURL{
                    let url = URL(string: photourl)
//                    userButton.kf.setImage(with: url, for: .normal)
                    userImage.kf.setImage(with: url)
                }
            }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userName.font = UIFont(name: "Comfortaa-Bold", size: 20)
        self.chefName.font = UIFont(name: "Comfortaa-Bold", size: 14)
        self.chefName.textColor = hexStringToUIColor(hex: "8F8F8F")
        self.chefIcon.image = UIImage(named: "local_dining-24px.emf")
        self.chefLabel.font = UIFont(name: "Comfortaa-Regular", size: 12)
        self.ratingLabel.font = UIFont(name: "Comfortaa-Regular", size: 12)
        self.ratingIcon.image = UIImage(named: "star-24px.emf")
//        self.userButton.translatesAutoresizingMaskIntoConstraints = false
//        self.userButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//        self.userButton.layer.cornerRadius = 0.5 * self.userButton.bounds.size.width
//        self.userButton.clipsToBounds = true
//        self.userButton.layer.cornerRadius = self.userButton.frame.width/2
//        self.userButton.clipsToBounds = true
//        self.userButton.setImage(UIImage(named: "Logo"), for: .normal)
        self.userImage.layer.borderWidth = 1
        self.userImage.layer.masksToBounds = false
        self.userImage.layer.borderColor = UIColor.black.cgColor
        self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        self.userImage.clipsToBounds = true
        self.userName.text = "Justin Liu"//"Bryten Foongsathaporn"
//        self.userName.text = "Bryten Foongsathaporn"
        self.chefName.text = "AKA Juicetin"
//        self.chefName.text = "AKA Bryten Foongsathaporn"
        self.chefLabel.text = "Super Chef"
        self.chefLabel.textColor = .black
        self.ratingLabel.text = "4.86 (216)"
    }
}
