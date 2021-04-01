//
//  InfoTableView.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class InfoTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        backgroundColor = .red

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
