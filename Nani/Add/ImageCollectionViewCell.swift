//
//  ImageCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/8.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var delegate : ButtonCollectionViewCellDelegate?
    
    lazy var imageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
//        button.frame = CGRect(x: 160, y: 100, width: 40, height: 40)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.clipsToBounds = true
        let photo = UIImage(named: "nani_placeholder")
        button.clipsToBounds = true
        button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let top: CGFloat = 10
//        let labelHeight: CGFloat = 20
        let leading: CGFloat = 20
//        let rightSpace: CGFloat = 300
        addSubview(imageButton)
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: topAnchor, constant: top),
            imageButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            imageButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -leading),
            imageButton.heightAnchor.constraint(equalToConstant: 250)
            ])
        imageButton.addTarget(self, action: #selector(showImagePicker(sender:)), for: .touchUpInside)
    }
    
    @objc func showImagePicker(sender: UIButton){
        delegate?.showImagePicker(sender: sender)
    }
}




