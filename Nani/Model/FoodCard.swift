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
    var chef: String
    var apt: String
    var time: String
    
    init(_ item: [String : Any], _ image: UIImage){
        self.name = item["Title"] as! String
        self.image = image
        self.price = item["Price"] as! Int
        let user = item["User"] as? [String: Any]
        self.chef = user!["Chef_name"] as! String
        self.apt = item["Room"] as! String
        self.time = ""
        let (hour, min) = self.calculate(item["Posted_time"] as! String, item["Expiry_hours"] as! Int)
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
}
