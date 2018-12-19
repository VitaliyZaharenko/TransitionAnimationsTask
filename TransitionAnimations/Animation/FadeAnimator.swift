//
//  FadeInAnimator.swift
//  TransitionAnimations
//
//  Created by vitali on 12/3/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class FadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var duration = 1.0
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        transitionContext.containerView.addSubview(toView)
        toView.alpha = 0.0
        fromView.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn,
                       animations: {
                        toView.alpha = 1.0
                        fromView.alpha = 0.0
        }, completion: { _ in
            fromView.alpha = 1.0
            transitionContext.completeTransition(true)
        })
    }
}
