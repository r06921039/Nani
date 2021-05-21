//
//  RatingCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/20.
//

import Foundation
import UIKit

class RatingCell:UITableViewCell{
    
    var delegate: AddReviewCellDelegate?
    
    @IBOutlet weak var starButton1: UIButton!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var starButton3: UIButton!
    @IBOutlet weak var starButton4: UIButton!
    @IBOutlet weak var starButton5: UIButton!
    @IBOutlet weak var tapStarLabel: UILabel!
    
    
    @IBAction func pressStar1(_ sender: Any) {
        self.starButton1.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.delegate?.tableViewCell(selectOn: 1)
        
    }
    @IBAction func pressStar2(_ sender: Any) {
        self.starButton1.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.delegate?.tableViewCell(selectOn: 2)
        
    }
    @IBAction func pressStar3(_ sender: Any) {
        self.starButton1.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.delegate?.tableViewCell(selectOn: 3)
        
    }
    @IBAction func pressStar4(_ sender: Any) {
        self.starButton1.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.delegate?.tableViewCell(selectOn: 4)
        
    }
    @IBAction func pressStar5(_ sender: Any) {
        self.starButton1.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star-24px.emf"), for: .normal)
        self.delegate?.tableViewCell(selectOn: 5)
       
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.starButton1.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton2.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton3.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton4.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.starButton5.setImage(UIImage(named: "star_outline_black_24dp.emf"), for: .normal)
        self.tapStarLabel.textColor = .lightGray
        self.tapStarLabel.font = UIFont(name: "Comfortaa-Regular", size: 11)
//        self.contentView.isUserInteractionEnabled = false
    }
    
}
