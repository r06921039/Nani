//
//  EditImageViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/26.
//

import Foundation
import UIKit

class EditImageViewCell:UITableViewCell{
    
    @IBOutlet weak var editButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.editButton.setImage(UIImage(named: "edit"), for: .normal)
        
        
    }
}
