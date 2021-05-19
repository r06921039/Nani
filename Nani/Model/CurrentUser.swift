//
//  CurrentUser.swift
//  Nani
//
//  Created by Jeff on 2021/5/19.
//

import Foundation

struct CurrentUser {
    
    static var photoURL = UserDefaults.standard.url(forKey: "photoURL") ?? URL(string: "")
    static var needUpdate = true
    static var uid = UserDefaults.standard.string(forKey: "uid") ?? ""
    static var average_Rating = UserDefaults.standard.float(forKey: "rating") ?? 0.0
    static var allergies = UserDefaults.standard.object(forKey: "allergies") ?? [0]
    static var chef_label = UserDefaults.standard.string(forKey: "chef_label") ?? "Newbie"
    static var chef_name = UserDefaults.standard.string(forKey: "chef_name") ?? ""
    static var food_items = UserDefaults.standard.object(forKey: "food_items") ?? []
    static var name = UserDefaults.standard.string(forKey: "name") ?? ""
    static var didLogin = UserDefaults.standard.bool(forKey: "didLogin") ?? false
    static var reviews = [0]
    static var total_ratings = 0
    static var index = 0
}
