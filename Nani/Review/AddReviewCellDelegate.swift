//
//  AddReviewCellDelegate.swift
//  Nani
//
//  Created by Jeff on 2021/5/21.
//

import Foundation
import UIKit

protocol AddReviewCellDelegate {
    func tableViewCell(valueChangedIn textField: UITextView, delegatedFrom cell: AddReviewCell)
    func tableViewCell(selectOn buttonNumber: Int)
}
