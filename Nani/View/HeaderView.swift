//
//  HeaderView.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class HeaderView: UIView, HeaderViewDelegate {
    
    func updateHeaderViewLabelOpacity(constant: CGFloat) {
    }
    
    func updateHeaderViewLabelSize(constant: CGFloat) {
        if constant > 0{
            let pec = 1 + (constant)/52 // 1 + (constant+44)/80
            let screenSize: CGRect = UIScreen.main.bounds
            let topPec = screenSize.width == 375 ? 1 + (constant)/120 : 1 + (constant)/75
            let opacityPec = 1 - (constant)/100 // 1 - (constant + 44)/147
            nameLabelTopAnchorConstraint?.constant = 10 * (topPec) //10
            nameLabelLeftAnchorConstraint?.constant = 15 * (pec) - 30*(constant)/241
            //print(constant)
            //print(nameLabelLeftAnchorConstraint?.constant)
            //nameLabelRightAnchorConstraint?.constant = -15 * (pec)
            
            costLabelLeftAnchorConstraint?.constant = 15 * (pec)
    //        costLabelRightAnchorConstraint?.constant = -15 * (pec)
            costLabel.layer.opacity = Float(opacityPec)
            
            cuisineLabelLeftAnchorConstraint?.constant = 15 * (pec)
            cuisineLabelRightAnchorConstraint?.constant = -15 * (pec)
            cuisineLabel.layer.opacity = Float(opacityPec)
            
            timeLabelLeftAnchorConstraint?.constant = 15 * (pec)
            timeLabelRightAnchorConstraint?.constant = -15 * (pec)
            timeLabel.layer.opacity = Float(opacityPec)
        }
    }
    
    var name: String?
    var cuisine: String?
    var time: String?
    var fee: String?
    var stars: String?
    var review: String?
    
    var nameLabelTopAnchorConstraint: NSLayoutConstraint?
    var nameLabelLeftAnchorConstraint: NSLayoutConstraint?
    var nameLabelRightAnchorConstraint: NSLayoutConstraint?
    var nameLabelHeightAnchorConstraint: NSLayoutConstraint?
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        label.numberOfLines = 2
        label.text = "Maple Walnut Muffins"
        label.textColor = .black
        return label
    }()
    

    var cuisineLabelTopAnchorConstraint: NSLayoutConstraint?
    var cuisineLabelLeftAnchorConstraint: NSLayoutConstraint?
    var cuisineLabelRightAnchorConstraint: NSLayoutConstraint?
    var cuisineLabelHeightAnchorConstraint: NSLayoutConstraint?
    var cuisineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Comfortaa-Light", size: 12.0)
        label.text = "By Bryten - 17K"
        label.textColor = .black
        return label
    }()
    
    var costLabelTopAnchorConstraint: NSLayoutConstraint?
    var costLabelLeftAnchorConstraint: NSLayoutConstraint?
    var costLabelRightAnchorConstraint: NSLayoutConstraint?
    var costLabelHeightAnchorConstraint: NSLayoutConstraint?
    var costLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Comfortaa-Light", size: 12.0)
        label.text = "Free - Pick up"
        label.textColor = .black
        return label
    }()
    
    var timeLabelTopAnchorConstraint: NSLayoutConstraint?
    var timeLabelLeftAnchorConstraint: NSLayoutConstraint?
    var timeLabelWidthAnchorConstraint: NSLayoutConstraint?
    var timeLabelRightAnchorConstraint: NSLayoutConstraint?
    var timeLabelHeightAnchorConstraint: NSLayoutConstraint?
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Comfortaa-Light", size: 12.0)
        label.text = "Expires in 2h49"
        label.layer.backgroundColor = hexStringToUIColor(hex: "#F0B357").cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textColor = .white
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cuisineLabel, costLabel ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalSpacing
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(nameLabel)
        nameLabelTopAnchorConstraint = nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        nameLabelLeftAnchorConstraint = nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        nameLabelRightAnchorConstraint = nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
        nameLabelHeightAnchorConstraint = nameLabel.heightAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([
            nameLabelTopAnchorConstraint!,
            nameLabelLeftAnchorConstraint!,
            nameLabelRightAnchorConstraint!,
            nameLabelHeightAnchorConstraint!
            ])
        
        addSubview(cuisineLabel)
        cuisineLabelTopAnchorConstraint = cuisineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5)
        cuisineLabelLeftAnchorConstraint = cuisineLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        cuisineLabelRightAnchorConstraint = cuisineLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15)
        cuisineLabelHeightAnchorConstraint = cuisineLabel.heightAnchor.constraint(equalToConstant: 15)
        NSLayoutConstraint.activate([
            cuisineLabelTopAnchorConstraint!,
            cuisineLabelLeftAnchorConstraint!,
            cuisineLabelRightAnchorConstraint!,
            cuisineLabelHeightAnchorConstraint!
            ])

        addSubview(costLabel)
        costLabelTopAnchorConstraint = costLabel.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 5)
        costLabelLeftAnchorConstraint = costLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        costLabelRightAnchorConstraint = costLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -150)
        costLabelHeightAnchorConstraint = costLabel.heightAnchor.constraint(equalToConstant: 15)
        NSLayoutConstraint.activate([
            costLabelTopAnchorConstraint!,
            costLabelLeftAnchorConstraint!,
            costLabelRightAnchorConstraint!,
            costLabelHeightAnchorConstraint!
            ])
        addSubview(timeLabel)
        timeLabel.textAlignment = .center
        timeLabelTopAnchorConstraint = timeLabel.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 0)
        timeLabelLeftAnchorConstraint = timeLabel.leftAnchor.constraint(equalTo: costLabel.rightAnchor, constant: 5)
        //timeLabelWidthAnchorConstraint = timeLabel.widthAnchor.constraint(equalToConstant: 70)
        timeLabelRightAnchorConstraint = timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        timeLabelHeightAnchorConstraint = timeLabel.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([
            timeLabelTopAnchorConstraint!,
            timeLabelLeftAnchorConstraint!,
            timeLabelRightAnchorConstraint!,
            timeLabelHeightAnchorConstraint!
            ])
   }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

