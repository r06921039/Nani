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
            cuisineLabel.text = "Italian - \(biz.price ?? "")"
            ratingLabel.text = "\(biz.rating ?? 0) (\(biz.review_count ?? 0))"
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "tennesse_taco_co"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .yellow
        return iv
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tennesse Taco Company"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = .white
        return label
    }()
    
    var cuisineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mexican - $$"
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        label.backgroundColor = .white
        return label
    }()
    
    var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4.4 (177)"
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .white
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "25-35 MIN"
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .white
        label.textAlignment = .right
        return label
    }()
    
    var feeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$6.89"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.backgroundColor = .white
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
        print(cellWidth)
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100)
            ])
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            nameLabel.widthAnchor.constraint(equalToConstant: (cellWidth*0.66)),
            nameLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(cuisineLabel)
        NSLayoutConstraint.activate([
            cuisineLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            cuisineLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            cuisineLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.66),
            cuisineLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: cuisineLabel.bottomAnchor, constant: 5),
            ratingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            ratingLabel.widthAnchor.constraint(equalToConstant: 150),
            ratingLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            timeLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.31),
            timeLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
        addSubview(feeLabel)
        NSLayoutConstraint.activate([
            feeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            feeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            feeLabel.widthAnchor.constraint(equalToConstant: cellWidth*0.31),
            feeLabel.heightAnchor.constraint(equalToConstant: 15)
            ])
    }
}
