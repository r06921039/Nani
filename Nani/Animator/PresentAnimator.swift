//
//  PresentAnimator.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit

class PresentAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    
    var itemFrame: CGRect
    var item: HomeViewCell
    var food_item: FoodCard
    
    init(item: HomeViewCell, itemFrame: CGRect, food_item: FoodCard) {
        self.itemFrame = itemFrame
        self.item = item
        self.food_item = food_item
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        
        
        
        // get the cell frame
        //print("itemFrame: \(itemFrame)")
        
        // get the picture
        let imageView = item.imageView
        let imageViewFrame = imageView.frame
        //print("imageViewFrame: \(imageViewFrame)")
        
        // modify the frame
        let imageViewFrameConverted = item.convert(imageViewFrame, to: UIApplication.shared.keyWindow!)
        //print("imageViewFrameConverted: \(imageViewFrameConverted)")
        
        // get the headerView
        let headerView = HeaderView(frame: CGRect(x: 15, y: 200, width: 345, height: 120))
        headerView.food = self.food_item
        headerView.backgroundColor = .white
        let headerViewOrigin = CGPoint(x: imageViewFrameConverted.origin.x, y: imageViewFrameConverted.origin.y + imageViewFrameConverted.height)
        headerView.frame = CGRect(origin: headerViewOrigin, size: CGSize(width: 345, height: 120))
        
        // get the test image
        let testImageView = UIImageView(image: item.imageView.image)
        testImageView.contentMode = .scaleAspectFill
        //print("original Image Size: \(testImageView.frame)")
        testImageView.frame = imageViewFrameConverted
        let heightAspect = itemFrame.width * 0.79625
        // add the subviews
        UIApplication.shared.keyWindow!.addSubview(testImageView)
        UIApplication.shared.keyWindow!.addSubview(headerView)
        //print("windowFram: \(UIApplication.shared.keyWindow!.frame) ")
        
        // configure the toView
        toVC.view.alpha = 0
        let whiteBackground = UIView(frame: UIApplication.shared.keyWindow!.frame)
        whiteBackground.backgroundColor = .white
        whiteBackground.alpha = 0
        transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        transitionContext.containerView.insertSubview(whiteBackground, belowSubview: toVC.view)
        
        whiteBackground.tag = 999
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                testImageView.frame = CGRect(x: 0, y: 0, width: self.itemFrame.width+1, height: heightAspect)
                headerView.frame = CGRect(x: 30, y: 233.6, width: 315, height: 130)
                fromVC.view.alpha = 1
                whiteBackground.alpha = 1
            },
            completion: { _ in
                toVC.view.alpha = 1
                fromVC.view.alpha = 1
                testImageView.removeFromSuperview()
                headerView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
    
}

