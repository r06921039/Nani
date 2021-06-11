//
//  Delegates.swift
//  Nani
//
//  Created by Jeff on 2021/6/11.
//

import Foundation
import UIKit

protocol UserCellDelegate {
    func idToIndex(_ id: String) -> Int
}

protocol MessagesControllerDelegate {
    func getUsers(delegatedFrom viewController: MessagesController)
}

