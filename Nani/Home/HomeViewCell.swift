//
//  HomeViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//
import UIKit
//import SDWebImage

class HomeViewCell: UICollectionViewCell {
    
//    var imageManager: SDWebImageManager = {
//        let manager = SDWebImageManager.shared()
//        return manager
//    }()
//
    
    var food: FoodCard? {
            didSet {
                nameLabel.text = food?.name
                priceLabel.text = food!.price == 0 ? "Free" : "$" + String(food!.price)
                chefLabel.text = food?.chef_name
                aptLabel.text = food?.apt
                timeLabel.text = food?.time
                imageView.image = food?.image
            }
    }
    var biz: Biz = Biz() {
        didSet {
            let defaultUrl = "http://s3-media3.fl.yelpcdn.com/bphoto/--8oiPVp0AsjoWHqaY1rDQ/o.jpg"
            guard let url: URL = URL(string: biz.url ?? defaultUrl) else {
                return
            }
//            imageManager.loadImage(with: url, options: SDWebImageOptions.cacheMemoryOnly, progress: nil) {
//                (img, data, error, cacheType, isFinished, url) in
//                let width: CGFloat = self.frame.width - 30 // based on the imageView autolayout size
//                let height: CGFloat = self.frame.height - 110
//                let size: CGSize = CGSize(width: width, height: height)
//                UIGraphicsBeginImageContext(size)
//                img?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//                self.imageView.image = UIGraphicsGetImageFromCurrentImageContext()
//                UIGraphicsEndImageContext()
//            }
            nameLabel.text = biz.name
            priceLabel.text = "Italian - \(biz.price ?? "")"
            ratingLabel.text = "\(biz.rating ?? 0) (\(biz.review_count ?? 0))"
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "tennesse_taco_co"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .yellow
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Maple Walnut Muffins"
        label.font = UIFont(name: "Comfortaa-Bold", size: 14)
        label.backgroundColor = .white
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Free"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.backgroundColor = .white
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4.4 (177)"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.backgroundColor = .white
        return label
    }()
    
    var chefLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bryten"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.backgroundColor = .white
        label.textAlignment = .right
        return label
    }()
    
    var aptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "17K"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.textAlignment = .right
        label.backgroundColor = .white
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        let cellWidth = frame.width - 30
        let leading: CGFloat = 20
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
            ])
        imageView.addSubview(timeLabel)
        timeLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 18),
            timeLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -10),
            timeLabel.widthAnchor.constraint(equalToConstant: 120),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            nameLabel.widthAnchor.constraint(equalToConstant: (cellWidth*0.66)),
            nameLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            priceLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.66),
            priceLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
//        addSubview(ratingLabel)
//        NSLayoutConstraint.activate([
//            ratingLabel.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 5),
//            ratingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//            ratingLabel.widthAnchor.constraint(equalToConstant: 150),
//            ratingLabel.heightAnchor.constraint(equalToConstant: 15)
//            ])
        addSubview(chefLabel)
        NSLayoutConstraint.activate([
            chefLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            chefLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -leading),
            chefLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.31),
            chefLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(aptLabel)
        NSLayoutConstraint.activate([
            aptLabel.topAnchor.constraint(equalTo: chefLabel.bottomAnchor, constant: 5),
            aptLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -leading),
            aptLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.31),
            aptLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
    }
}
