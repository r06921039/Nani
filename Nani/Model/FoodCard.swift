//
//  File.swift
//  Nani
//
//  Created by Jeff on 2021/4/9.
//

import Foundation
import UIKit

struct FoodCard{
    var name: String
    var image: UIImage
    var price: Int
    var user: Int
    var apt: String
    var time: String
    var contains: String
    var notes: String
    var servings: Int
    var pickup: Bool
    var chef_name: String
    var reviews: [Int]
    var posted_time: String
    var expiry_hours: Int
    var order: Int
    
    init(_ item: [String : Any], _ image: UIImage, _ allergens: [String]){
        self.name = item["Title"] as! String
        self.image = image
        self.price = item["Price"] as! Int
//        let user = item["User"] as? [String: Any]
        self.chef_name = item["Chef_name"] as! String
        self.user = item["User"] as! Int
        self.apt = item["Room"] as! String
        self.time = ""
        let Contains = item["Contains"] as? [Int]
        var temp: [String] = []
        for index in Contains!{
            temp.append(allergens[index])
        }
        self.contains = "Contains: " + temp.joined(separator: ", ")
        self.notes = item["Notes"] as! String
        self.servings = item["Servings"] as! Int
        self.pickup = item["Pickup"] as! Bool
        self.reviews = item["Reviews"] as! [Int]
        self.posted_time = item["Posted_time"] as! String
        self.expiry_hours = item["Expiry_hours"] as! Int
        self.order = item["Order"] as! Int
        
        let (hour, min) = self.calculate(self.posted_time, self.expiry_hours)
        self.time = hour < 0 ? "Expired" : "Expires in " + String(hour) + "h " + String(min)
    }
    
    func calculate(_ post: String, _ expiry: Int) -> (Int, Int){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateFormatterHour = DateFormatter()
        dateFormatterHour.dateFormat = "HH"
        var date = dateFormatterGet.date(from: post)
        let expiredDate = date!.addingTimeInterval(Double(expiry * 60 * 60))
        var currentDate = Date()
        let calendar = Calendar.current
        let realDate = dateFormatterGet.string(from: currentDate)
        let realDate_1 = dateFormatterGet.date(from: realDate)!
        let elapsedTime = expiredDate.timeIntervalSince(realDate_1)
        let hours = floor(elapsedTime / 60 / 60)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)

        return (Int(hours), Int(minutes))
    }
    
    mutating func updateTime(){
        let (hour, min) = self.calculate(self.posted_time, self.expiry_hours)
        self.time = hour < 0 ? "Expired" : "Expires in " + String(hour) + "h " + String(min)
    }
}
