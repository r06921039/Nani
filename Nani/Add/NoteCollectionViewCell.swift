//
//  NoteCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/9.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
    
    var delegate: CollectionViewCellDelegate?

    
    var dishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dish name"
        label.font = UIFont(name: "Comfortaa-Regular", size: 16)
        label.backgroundColor = .white
        return label
    }()
    
    var dishTextView: UITextView = {
        let textField = UITextView()
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
        let rightSpace: CGFloat = 20
        addSubview(dishLabel)
        NSLayoutConstraint.activate([
            dishLabel.topAnchor.constraint(equalTo: topAnchor, constant: top),
            dishLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            dishLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -leading),
            dishLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        dishTextView.delegate = self
        addSubview(dishTextView)
        dishTextView.setBottomBorder()
        NSLayoutConstraint.activate([
            dishTextView.topAnchor.constraint(equalTo: dishLabel.bottomAnchor, constant: 15),
            dishTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            dishTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightSpace),
            dishTextView.heightAnchor.constraint(equalToConstant: 80)
            ])
//        dishTextView.delegate = self
//        dishTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func textViewDidChange(_ textView: UITextView) {
        textView.isScrollEnabled = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        delegate?.collectionViewCell(valueChangedIn: dishTextField, delegatedFrom: self)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        endEditing(true)
//        return false
//    }
}

