//
//  DishContainsCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/9.
//

import UIKit

class DishContainsCollectionViewCell: UICollectionViewCell {
    
    var delegate : ButtonCollectionViewCellDelegate?
    
    var dishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your dish contains:"
        label.font = UIFont(name: "Comfortaa-Regular", size: 16)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var eggsButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("eggs", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var milkButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("milk", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var shrimpButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("shrimp", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var peanutButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("peanut", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var porkButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("pork", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var soyButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("soy", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var seafoodButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("seafood", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var wheatButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("wheat", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Regular", size: 16)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelected), for: .touchUpInside)
        return button
        }()
    
    lazy var othersButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("others...", for: .normal)
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
        addSubview(eggsButton)
        NSLayoutConstraint.activate([
            eggsButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            eggsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            eggsButton.widthAnchor.constraint(equalToConstant: 70),
            eggsButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(milkButton)
        NSLayoutConstraint.activate([
            milkButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            milkButton.leftAnchor.constraint(equalTo: eggsButton.rightAnchor, constant: leading),
            milkButton.widthAnchor.constraint(equalToConstant: 70),
            milkButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(shrimpButton)
        NSLayoutConstraint.activate([
            shrimpButton.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 20),
            shrimpButton.leftAnchor.constraint(equalTo: milkButton.rightAnchor, constant: leading),
            shrimpButton.widthAnchor.constraint(equalToConstant: 90),
            shrimpButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(peanutButton)
        NSLayoutConstraint.activate([
            peanutButton.topAnchor.constraint(equalTo: eggsButton.bottomAnchor, constant: top),
            peanutButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            peanutButton.widthAnchor.constraint(equalToConstant: 90),
            peanutButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(porkButton)
        NSLayoutConstraint.activate([
            porkButton.topAnchor.constraint(equalTo: eggsButton.bottomAnchor, constant: top),
            porkButton.leftAnchor.constraint(equalTo: peanutButton.rightAnchor, constant: leading),
            porkButton.widthAnchor.constraint(equalToConstant: 70),
            porkButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(soyButton)
        NSLayoutConstraint.activate([
            soyButton.topAnchor.constraint(equalTo: eggsButton.bottomAnchor, constant: top),
            soyButton.leftAnchor.constraint(equalTo: porkButton.rightAnchor, constant: leading),
            soyButton.widthAnchor.constraint(equalToConstant: 70),
            soyButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(seafoodButton)
        NSLayoutConstraint.activate([
            seafoodButton.topAnchor.constraint(equalTo: peanutButton.bottomAnchor, constant: top),
            seafoodButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            seafoodButton.widthAnchor.constraint(equalToConstant: 95),
            seafoodButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(wheatButton)
        NSLayoutConstraint.activate([
            wheatButton.topAnchor.constraint(equalTo: peanutButton.bottomAnchor, constant: top),
            wheatButton.leftAnchor.constraint(equalTo: seafoodButton.rightAnchor, constant: leading),
            wheatButton.widthAnchor.constraint(equalToConstant: 76),
            wheatButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        addSubview(othersButton)
        NSLayoutConstraint.activate([
            othersButton.topAnchor.constraint(equalTo: peanutButton.bottomAnchor, constant: top),
            othersButton.leftAnchor.constraint(equalTo: wheatButton.rightAnchor, constant: leading),
            othersButton.widthAnchor.constraint(equalToConstant: 100),
            othersButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
    }
    
    @objc func handleSelected(sender: UIButton) {
        if sender.backgroundColor == UIColor.gray{
            sender.backgroundColor = hexStringToUIColor(hex: "#F0B357")
        }
        else{
            sender.backgroundColor = UIColor.gray
        }
    }
}
