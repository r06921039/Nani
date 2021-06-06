//
//  FoodTagsCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/6/6.
//

import UIKit

class FoodTagsCollectionViewCell: UICollectionViewCell {
    
    var delegate : CollectionViewCellDelegate?
    
    var dishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dish tags:"
        label.font = UIFont(name: "Comfortaa-Regular", size: 16)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var DessertButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("dessert", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var DrinkButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("drink", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var FoodButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("food", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var OtherButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("other", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
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
        let buttonTop: CGFloat = 20
        let labelHeight: CGFloat = 20
        let leading: CGFloat = 20
        let rightSpace: CGFloat = 300
        addSubview(dishLabel)
        NSLayoutConstraint.activate([
            dishLabel.topAnchor.constraint(equalTo: topAnchor, constant: top),
            dishLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            dishLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -leading),
            dishLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        addSubview(DessertButton)
        NSLayoutConstraint.activate([
            DessertButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            DessertButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            DessertButton.widthAnchor.constraint(equalToConstant: 90),
            DessertButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(DrinkButton)
        NSLayoutConstraint.activate([
            DrinkButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            DrinkButton.leftAnchor.constraint(equalTo: DessertButton.rightAnchor, constant: leading),
            DrinkButton.widthAnchor.constraint(equalToConstant: 70),
            DrinkButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(FoodButton)
        NSLayoutConstraint.activate([
            FoodButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            FoodButton.leftAnchor.constraint(equalTo: DrinkButton.rightAnchor, constant: leading),
            FoodButton.widthAnchor.constraint(equalToConstant: 70),
            FoodButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(OtherButton)
        NSLayoutConstraint.activate([
            OtherButton.topAnchor.constraint(equalTo: DessertButton.bottomAnchor, constant: top),
            OtherButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            OtherButton.widthAnchor.constraint(equalToConstant: 70),
            OtherButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        
    }
    
    @objc func handleSelected(sender: UIButton) {
        if sender.backgroundColor == UIColor.gray{
            sender.backgroundColor = hexStringToUIColor(hex: "#F0B357")
            delegate?.collectionViewCell(selectOnTags: sender)
        }
        else{
            sender.backgroundColor = UIColor.gray
            delegate?.collectionViewCell(deselectOnTags: sender)
        }
    }
    
    func refresh(){
        self.DessertButton.backgroundColor = UIColor.gray
        self.DrinkButton.backgroundColor = UIColor.gray
        self.FoodButton.backgroundColor = UIColor.gray
        self.OtherButton.backgroundColor = UIColor.gray
    }
    
}
