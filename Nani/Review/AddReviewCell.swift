//
//  AddReviewCell.swift
//  Nani
//
//  Created by Jeff on 2021/5/20.
//

import Foundation
import UIKit

class AddReviewCell: UITableViewCell, UITextViewDelegate{
    
    var delegate: AddReviewCellDelegate?
    
    var textView: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Comfortaa-Regular", size: 16)
        textField.backgroundColor = .white
        textField.isEditable = true
        textField.isScrollEnabled = false
        textField.text = "Review"
        textField.textColor = UIColor.lightGray
        return textField
    }()
    
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()
    
    var textChanged: ((String) -> Void)?
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
        
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        self.delegate?.tableViewCell(valueChangedIn: self.textView, delegatedFrom: self)
    }
  
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .white
        
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.topAnchor.constraint(equalTo:topAnchor, constant: 0),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        addSubview(textView)
        textView.delegate = self
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: topSeperator.bottomAnchor, constant: 0),
            textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            textView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            ])
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Review"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
