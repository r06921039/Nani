//
//  AddReviewController.swift
//  Nani
//
//  Created by Jeff on 2021/5/20.
//

import Foundation
import UIKit
import Firebase


class AddReviewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tablevVew: UITableView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func send(_ sender: Any) {
        let review_id = self.total_reviews
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy MMM dd HH:mm"
        var currentDate = Date()
        let realDate = dateFormatterGet.string(from: currentDate)
        let new_review = [
            "Comment" : self.review,
            "Food_item" : self.food_id,
            "Posted_time" : realDate,
            "Rating" : self.star,
            "User" : CurrentUser.uid
        ] as [String : Any]
        self.reviews?.insert(review_id, at: 0)
        if (self.user_reviews == [-1]){
            self.user_reviews = [review_id]
        }
        else{
            self.user_reviews?.insert(review_id, at: 0)
        }
        self.ref.child("Reviews").child(String(review_id)).setValue(new_review)
        self.ref.child("Food_items").child(String(self.food_id!)).child("Reviews").setValue(self.reviews)
        self.ref.child("Total_reviews").setValue(self.total_reviews+1)
        self.ref.child("Users").child(String(CurrentUser.index)).child("Reviews").setValue(self.user_reviews)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    var review:String = ""
    var star:Int = 0
    var total_reviews:Int = 0
    var food_id: Int?
    var reviews:[Int]?
    var user_reviews:[Int]? = [-1]
    var is_rating: Bool = false
    var is_comment: Bool = false
    var total_users: Int = 0
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getTotalReviews()
    }
    
    
    func setupViews(){
        self.tablevVew.register(AddReviewCell.self, forCellReuseIdentifier: "AddReviewCell")
        let nib = UINib.init(nibName: "RatingCell", bundle: nil)
        self.tablevVew.register(nib, forCellReuseIdentifier: "RatingCell")
        self.tablevVew.tableFooterView = UIView()
        self.tablevVew.separatorStyle = .none
        self.tablevVew.allowsSelection = false
        self.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 16)!]
        self.cancelButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 16)!,
                                                  NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#F0B357")], for: .normal)
        self.sendButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Comfortaa-Bold", size: 16)!,
                                                  NSAttributedString.Key.foregroundColor: hexStringToUIColor(hex: "#F0B357")], for: .normal)
        self.sendButton.isEnabled = false
    }
    
    func getTotalReviews(){
        self.ref.child("Total_reviews").observe(DataEventType.value, with: { (snapshot) in
            if let reviewsNumber = snapshot.value as? Int{
                self.total_reviews = reviewsNumber
            }
        })
        
        
        
        self.ref.child("Food_items").child(String(self.food_id!)).child("Reviews").observe(DataEventType.value, with: { (snapshot) in
            if let reviews = snapshot.value as? [Int]{
                self.reviews = reviews
            }
        })
        self.ref.child("Users").child(String(CurrentUser.index)).child("Reviews").observe(DataEventType.value, with: { (snapshot) in
            if let user_reviews = snapshot.value as? [Int]{
                self.user_reviews = user_reviews
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
            cell.delegate = self
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddReviewCell", for: indexPath) as! AddReviewCell
            cell.contentView.isUserInteractionEnabled = false
            cell.textChanged {[weak tableView] (newText: String) in
                DispatchQueue.main.async {
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
            }
            cell.delegate = self
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    
}


extension AddReviewController: AddReviewCellDelegate{
    
    func checkValid(){
        if (self.is_comment && self.is_rating){
            self.sendButton.isEnabled = true
        }
        else{
            self.sendButton.isEnabled = false
        }
    }
    
    func tableViewCell(valueChangedIn textField: UITextView, delegatedFrom cell: AddReviewCell) {
        
        self.review = textField.text
        
        self.is_comment = !textField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        self.checkValid()
    }
    
    func tableViewCell(selectOn buttonNumber: Int) {
        self.star = buttonNumber
        self.is_rating = self.star != 0
        self.checkValid()
    }
    
}
