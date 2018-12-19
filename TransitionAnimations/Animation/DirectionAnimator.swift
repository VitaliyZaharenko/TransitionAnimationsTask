//
//  DirectionAnimator.swift
//  TransitionAnimations
//
//  Created by vitali on 12/3/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit


enum TransitionDirection {
    case left, right, up, down, random
    
    fileprivate var maskTuple: (CGFloat, CGFloat) {
        get {
            switch self {
            case .left:
                return (-1.0, 0)
            case .right:
                return (1.0, 0)
            case .up:
                return (0, -1.0)
            case .down:
                return (0, 1.0)
            case .random:
                let randoms: [(CGFloat, CGFloat)] = [(1.0, 0), (-1.0, 0), (0, -1.0), (0, 1.0)]
                let idx = Int(arc4random_uniform(UInt32(randoms.count)))
                return randoms[idx]
            }
        }
    }
    
}


class DirectionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 1.0
    var isDismissed = false
    
    var transitionDirection: TransitionDirection = .left
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let contanerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let fromViewTransform = fromView.transform
        let toView = transitionContext.view(forKey: .to)!
        let toViewTransform = toView.transform
        
        
        var (multX, multY) = transitionDirection.maskTuple
        
        if isDismissed {
            multX *= -1
            multY *= -1
        }
        
        let (sizeX, sizeY) = (fromView.frame.width, fromView.frame.height)
        let fromViewInitialTransform = fromViewTransform
        let fromViewResultTransform = fromViewTransform.translatedBy(x: multX * sizeX, y: multY * sizeY)
        let toViewInitialTransform = toViewTransform.translatedBy(x: multX * sizeX * -1, y: multY * sizeY * -1)
        let toViewResultTransform = toViewTransform
        contanerView.addSubview(toView)
        
        fromView.transform = fromViewInitialTransform
        toView.transform = toViewInitialTransform
        
        UIView.animate(withDuration: duration,
                       delay: 0.0, options: .curveEaseInOut, animations: {
                        toView.transform = toViewResultTransform
                        fromView.transform = fromViewResultTransform
        }, completion: { _ in
            fromView.transform = fromViewTransform
            toView.transform = toViewTransform
            transitionContext.completeTransition(true)
        })
        
        
        
    }
    
    
    
    
}
