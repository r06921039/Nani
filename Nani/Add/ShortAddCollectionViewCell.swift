//
//  ShortAddCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/8.
//

import UIKit

class ShortAddCollectionViewCell: UICollectionViewCell {
    
    var delegate: CollectionViewCellDelegate?

    
    var dishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dish name"
        label.font = UIFont(name: "Comfortaa-Regular", size: 16)
        label.backgroundColor = .white
        return label
    }()
    
    var dishTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Comfortaa-Regular", size: 16)
        textField.backgroundColor = .white
        return textField
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
        
        addSubview(dishTextField)
        dishTextField.setBottomBorder()
        NSLayoutConstraint.activate([
            dishTextField.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 15),
            dishTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            dishTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightSpace),
            dishTextField.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        dishTextField.delegate = self
        dishTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.collectionViewCell(valueChangedIn: dishTextField, delegatedFrom: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}

extension ShortAddCollectionViewCell: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegate {
            return delegate.collectionViewCell(textField: textField, shouldChangeCharactersIn: range, replacementString: string, delegatedFrom: self)
        }
        return true
    }
}
