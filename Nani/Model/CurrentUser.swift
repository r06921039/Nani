//
//  CurrentUser.swift
//  Nani
//
//  Created by Jeff on 2021/5/19.
//

import Foundation
import FirebaseAuth

struct CurrentUser {
    
    static var photoURL = Auth.auth().currentUser?.photoURL
    static var needUpdate = true
    static var uid = UserDefaults.standard.string(forKey: "uid") ?? ""
    static var average_Rating = UserDefaults.standard.double(forKey: "rating") ?? 0.0
    static var allergies = UserDefaults.standard.object(forKey: "allergies") ?? [0]
    static var chef_label = UserDefaults.standard.string(forKey: "chef_label") ?? "Newbie"
    static var chef_name = UserDefaults.standard.string(forKey: "chef_name") ?? ""
    static var food_items = UserDefaults.standard.object(forKey: "food_items") ?? []
    static var name = UserDefaults.standard.string(forKey: "name") ?? ""
    static var didLogin = Auth.auth().currentUser != nil
    static var reviews = [0] // need to be fixed
    static var total_ratings = 0
    static var index = 0
}
