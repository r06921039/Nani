//
//  Reivew.swift
//  Nani
//
//  Created by Jeff on 2021/4/12.
//

import Foundation
import UIKit

struct Review {
    var comment: String
    var food_item: Int
    var posted_time: String
    var rating: Int
    var user: Int
    
    init(_ item: [String : Any]){
        self.comment = item["Comment"] as! String
        self.food_item = item["Food_item"] as! Int
        self.posted_time = item["Posted_time"] as! String
        self.rating = item["Rating"] as! Int
        self.user = item["User"] as! Int
    }
}
