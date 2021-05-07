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
        dishTextView.textContainer.maximumNumberOfLines = 3
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
        delegate?.collectionViewCell(valueChangedIn: textView, delegatedFrom: self)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isScrollEnabled = false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let existingLines = textView.text.components(separatedBy: CharacterSet.newlines)
        let newLines = text.components(separatedBy: CharacterSet.newlines)
        let linesAfterChange = existingLines.count + newLines.count - 1
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textWidth = textView.frame.inset(by: textView.textContainerInset).width
        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;

        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: textView.font!)
        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
        
        return linesAfterChange <= textView.textContainer.maximumNumberOfLines && numberOfLines <= 3
    }
    
    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: DBL_MAX),
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedString.Key.font: font],
            context: nil).size
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

