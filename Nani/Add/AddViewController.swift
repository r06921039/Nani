//
//  AddViewController.swift
//  Nani
//
//  Created by Jeff on 2021/4/7.
//

import UIKit
import YPImagePicker

class AddViewController: UIViewController, UITextFieldDelegate{
    
    lazy var imageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
//        button.frame = CGRect(x: 160, y: 100, width: 40, height: 40)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.clipsToBounds = true
        let photo = UIImage(named: "nani_placeholder")
        button.clipsToBounds = true
        button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.font = UIFont(name: "Comfortaa-Bold", size: 20)
        label.textColor = hexStringToUIColor(hex: "#F0B357")
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(AddCollectionViewCell.self, forCellWithReuseIdentifier: "AddCell")
        cv.register(ShortAddCollectionViewCell.self, forCellWithReuseIdentifier: "ShortCell")
        cv.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "ImageCell")
        cv.register(DishContainsCollectionViewCell.self, forCellWithReuseIdentifier: "DishContainsCell")
        cv.register(NoteCollectionViewCell.self, forCellWithReuseIdentifier: "NoteCell")
//        cv.register(InfoDetailCollectionViewCell.self, forCellWithReuseIdentifier: "InfoDetailCell")
//        cv.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCell")
//        cv.register(DetailHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DetailHeader")
//        cv.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
//        cv.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "EmptyCell")
        cv.contentInsetAdjustmentBehavior = .never
        cv.backgroundColor = .white
        cv.keyboardDismissMode = .onDrag
        return cv
    }()
    
    
    
    func setupView(){
        let top: CGFloat = 20
        let leading: CGFloat = 20
        let labelHeight: CGFloat = 20
        
        self.view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: top),
            titleLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
            titleLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -leading),
            titleLabel.heightAnchor.constraint(equalToConstant: labelHeight)
            ])
        
//        self.view.addSubview(imageButton)
//        NSLayoutConstraint.activate([
//            imageButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: top),
//            imageButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: leading),
//            imageButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -leading),
//            imageButton.heightAnchor.constraint(equalToConstant: 250)
//            ])
//        imageButton.addTarget(self, action: #selector(showImagePicker(sender:)), for: .touchUpInside)
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self,selector:#selector(self.keyboardWillShow),name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardWillHide),name:UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: Notification) {

            guard let userInfo = notification.userInfo,

                let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
                else{
                    return

            }

            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: {
            self.collectionView.contentInset = contentInset
        }, completion: nil)
        
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//               // if keyboard size is not available for some reason, dont do anything
//               return
//            }
//
//          // move the root view up by the distance of keyboard height
//        self.view.frame.origin.y = 0 - keyboardSize.height

    }

    @objc func keyboardWillHide(notification: Notification){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            self.collectionView.contentInset = UIEdgeInsets.zero
        }, completion: nil)
        
//        self.view.frame.origin.y = 0
    }

    
//    @objc func showImagePicker(sender: UIButton){
//        var config = YPImagePickerConfiguration()
//        config.isScrollToChangeModesEnabled = false
//        config.startOnScreen = YPPickerScreen.library
//        config.hidesStatusBar = false
//        config.icons.capturePhotoImage = UIImage(named: "Camera_Capture")!
//        config.colors.tintColor = hexStringToUIColor(hex: "#F0B357")
//        let picker = YPImagePicker(configuration: config)
//        picker.didFinishPicking { [unowned picker] items, _ in
//            if let photo = items.singlePhoto {
//                self.imageButton.setImage(photo.image, for: .normal)
//                self.imageButton.imageView!.contentMode = .scaleAspectFill
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//        present(picker, animated: true, completion: nil)
//    }
    
    
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = hexStringToUIColor(hex: "#F0B357").cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}

extension UITextView {
    func setBottomBorder() {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.layer.borderColor = hexStringToUIColor(hex: "#F0B357").cgColor
        self.layer.cornerRadius = 8
        self.isScrollEnabled = false
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = hexStringToUIColor(hex: "#F0B357").cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 0.0
    }
    
}

extension AddViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
                    cell.delegate = self
                    return cell
        }
        if (indexPath.row == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as! AddCollectionViewCell
                    cell.delegate = self
                    return cell
        }
        else if (2 <= indexPath.row && indexPath.row <= 5){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShortCell", for: indexPath) as! ShortAddCollectionViewCell
                    cell.delegate = self
            switch indexPath.row {
            case 2:
                cell.dishLabel.text = "Your apartment"
            case 3:
                cell.dishLabel.text = "Price per serving"
            case 4:
                cell.dishLabel.text = "Total Serving"
            case 5:
                cell.dishLabel.text = "Expire in hours"
            default:
                cell.dishLabel.text = ""
            }
            return cell
        }
        else if (indexPath.row == 6){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishContainsCell", for: indexPath) as! DishContainsCollectionViewCell
                    cell.delegate = self
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCollectionViewCell
            cell.dishLabel.text = "Notes to customers/caption:"
//            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == 0){
            return CGSize(width: view.frame.width, height: 250)
        }
        if (indexPath.row == 6){
            return CGSize(width: view.frame.width, height: 200)
        }
        if (indexPath.row == 7){
            return CGSize(width: view.frame.width, height: 180)
        }
        return CGSize(width: view.frame.width, height: 80)
    }
}

extension AddViewController: CollectionViewCellDelegate {

    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: AddCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            print("textField text: \(text) from cell: \(indexPath))")
//            textFieldsTexts[indexPath] = text
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: AddCollectionViewCell)  -> Bool {
        print("Validation action in textField from cell: \(String(describing: collectionView.indexPath(for: cell)))")
        return true
    }
    
    func collectionViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: ShortAddCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell), let text = textField.text {
            print("textField text: \(text) from cell: \(indexPath))")
//            textFieldsTexts[indexPath] = text
        }
    }

    func collectionViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: ShortAddCollectionViewCell)  -> Bool {
        print("Validation action in textField from cell: \(String(describing: collectionView.indexPath(for: cell)))")
        return true
    }

}

extension AddViewController: ButtonCollectionViewCellDelegate{
    func showImagePicker(sender: UIButton){
            var config = YPImagePickerConfiguration()
            config.isScrollToChangeModesEnabled = false
            config.startOnScreen = YPPickerScreen.library
            config.hidesStatusBar = false
            config.icons.capturePhotoImage = UIImage(named: "Camera_Capture")!
            config.colors.tintColor = hexStringToUIColor(hex: "#F0B357")
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, _ in
                if let photo = items.singlePhoto {
                    sender.setImage(photo.image, for: .normal)
                    sender.imageView!.contentMode = .scaleAspectFill
                }
                picker.dismiss(animated: true, completion: nil)
            }
            present(picker, animated: true, completion: nil)
        }
}

