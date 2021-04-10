//
//  CollectionViewCellDelegate.swift
//  Nani
//
//  Created by Jeff on 2021/4/8.
//

import UIKit

protocol CollectionViewCellDelegate {
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: AddCollectionViewCell)
    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: AddCollectionViewCell)  -> Bool
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: ShortAddCollectionViewCell)
    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: ShortAddCollectionViewCell)  -> Bool
}

protocol ButtonCollectionViewCellDelegate {
    func showImagePicker(sender: UIButton)
}
