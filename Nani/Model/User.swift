//
//  User.swift
//  Nani
//
//  Created by Jeff on 2021/4/12.
//

import Foundation
import UIKit

struct User{
    var allergies: [Int]
    var average_rating: Double
    var chef_name: String
    var food_items: [Int]
    var name: String
//    var picture: UIImage
    var reviews: [Int]?
    var total_ratings: Int
    var chef_label: String
    var photoURL: String
    var index: Int
    var id: String
    
    init(_ item: [String : Any]){
        self.allergies = item["Allergies"] as! [Int]
        self.average_rating = item["Average_Rating"] as! Double
        self.chef_name = item["Chef_name"] as! String
        self.food_items = item["Food_items"] as! [Int]
        self.name = item["Name"] as! String
//        self.picture = image
        self.reviews = item["Reviews"] as? [Int]
        self.total_ratings = item["Total_Ratings"] as! Int
        self.chef_label = item["Chef_label"] as! String
        self.photoURL = item["photoURL"] as! String
        self.index = item["Index"] as! Int
        self.id = item["ID"] as! String
    }
}
